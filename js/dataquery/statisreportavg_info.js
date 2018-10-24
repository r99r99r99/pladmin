
var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
var station;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
    
	var levelparam = {parentCode:'0017'};
	$http({
   		 method:'POST',
			 url:'getPublicList.do',
			 params:levelparam,
			 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
			 })
			 .success(function(response){
		    	 $scope.typelist = response;
		    	//查询条件初始化
		    	var stationParam = "";
		    	$http({
		    		 method:'POST',
		    		 url:'statisreportavg_init.do',
		    		 params:stationParam})
		    		 .success(function(response){
		    			 $scope.u=response;
		    			 setTimeout(function (){
		    					$scope.query();
		    				}, 1000);
		    	     });
   	}); 
	
	
	
	
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		          	  station = row.entity;
		          }
		    },
		    multiSelect:false,
		    modifierKeysToMultiSelect :false,
		    noUnselect:true,
		    enableRowSelection: true,
		    enableRowHeaderSelection:false,
		    headerRowHeight: 50,
		    paginationPageSizes: [25, 50, 100],
			paginationPageSize: 25,
			enableColumnResizing:true,
		    enableGridMenu: true,
		    enableSelectAll: true,
		    exporterCsvFilename: '平均报表',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  firstpage = row.entity;
		      });
		    }
		  };
	$scope.query = function(){
		 var endDate = $('#endDate').val();
		 var startDate = $('#startDate').val();
		 if(ifBeginLaterEnd(startDate,endDate)){
				$(".btn-primary").removeAttr("disabled");
				return;
		};
		if($scope.u.indicatorIds==null||$scope.u.indicatorIds==""){
			alert("请选择参数");
			return ;
		}
		//获得统计参数
		var indicatorIds = "";
		angular.forEach($scope.u.indicatorIds, function ( item ) {
			indicatorIds = item.id;
	    });
		if(indicatorIds==null||indicatorIds==""){
			alert("请选择监测参数");
			return;
		}
		//获得统计类型
		var statTypes = "0";
		angular.forEach($scope.u.statTypes, function ( item ) {
			statTypes = statTypes +","+item.id;
	    });
		if(statTypes=="0"){
			alert("请选择监测类型");
			return ;
		}
		var queryParam = {
				stationId:$scope.u.stationId,
				indicatorIds:indicatorIds,
				beginDate:startDate,
				endDate:endDate,
				collectType:$scope.u.collectType,
				statTypes:statTypes
		};
		$(".btn-primary").attr('disabled',"true");
		 $http({
			 method:'POST',
			 url:'statisreportavg_show.do',
			 params:queryParam}) 
			 .success(function(response){
				 var pageResult = response.pageResult;
				 $(".btn-primary").removeAttr("disabled"); 
				  row = pageResult.rows;
				  col = pageResult.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
				  showData(response);
		 });
	};
   
	
});

function showData(response){
	
		
		
	var plots = response.plotLines;
    
    var plotArray=eval(plots);
    var plotLines = new Array();
    $.each(plotArray,function(n,plot){
    	var plotLine={
    			color:plot.color,           //线的颜色，定义为红色
		        dashStyle:plot.dashStyle,     //默认值，这里定义为实线
		        value:plot.value,               //定义在那个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
		        width:plot.width,              //标示线的宽度，2px
		        label:{
		            text:plot.text,     //标签的内容
		            align:plot.align,                //标签的水平位置，水平居左,默认是水平居中center
		            x:plot.x                         //标签相对于被定位的位置水平偏移的像素，重新定位，水平居左10px
		        }
    	};
    	plotLines.push(plotLine);
    });
    	
	var alldata = response.datas;
	
	var result = new Array();
	var step = 1;
	
	
	for(var j=0;j<alldata.length;j++){
		var stationdata = alldata[j].datas;
		var size = stationdata.length;
		if(size>10){
			step = Math.ceil(size/10);
		}
		var res = new Array();
		for(var i = 0;i < stationdata.length; i++) {
			var ves = new Array();
			ves.push(stationdata[i].xtime);
			ves.push(stationdata[i].ydata);
			res.push(ves);
		}
		var par = {
				name:alldata[j].fieldName,
				data:res
		};
		result.push(par);
	}
	
	$('#container').highcharts({
		plotOptions:{
            series:{
                turboThreshold:100000//set it to a larger threshold, it is by default to 1000
            }
        },
        chart: {
            zoomType: 'x',
            backgroundColor: '#F5F6F6'
        },
        title: {
            text: response.indicator.title + '走势图'
        },
        subtitle: {
            text: document.ontouchstart === undefined ?
            '鼠标拖动可以进行缩放' : '手势操作进行缩放'
        },
        xAxis: {
        	type: 'category',
        	labels: { 
        		step:step,	
                formatter: function() { 
                               return  this.value; 
                } 
            } 
        },
        credits: {
        	enabled: false
    	},
        tooltip: {
        	formatter: function () {
				return '' + this.key +
				'的数值  <b>' + this.y + '</b>';
			},
            borderWidth: 0,
            backgroundColor: 'none',
            pointFormat: '{point.y}',
            headerFormat: '',
            shadow: false,
            style: {
                fontSize: '15px'
            }
        },
        yAxis: {
            title: {
                text: response.indicator.unitName
            },
            plotLines:plotLines
        },
        legend: {
            enabled: true
        },
        
        series: result
    });	
	
}