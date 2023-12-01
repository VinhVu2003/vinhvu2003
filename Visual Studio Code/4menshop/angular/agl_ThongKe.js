var app = angular.module('ThongKe',[]);
app.controller('ThongKeController',function($scope,$http){
    $scope.convertDate=function(time)
    {
        var date = new Date(time);
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2); // Thêm zero-padding cho tháng
        var day = ('0' + date.getDate()).slice(-2); // Thêm zero-padding cho ngày
        return year + '-' + month + '-' + day;
    }
    ////////////////////////////////////////////////////////////////////
    $scope.listDoanhThu;
    $scope.ThongKeDoanhThu = function(){
        $scope.showDiv = true;
        if($scope.fr_NgayTao == null || $scope.to_NgayTao == null){
            alert("Vui lòng chọn khoảng thời gian thống kê")
        }
        else{
            $http({
                method:'GET',
                url:current_url+'/api/ThongKe/ThongKeDoanhThu?fr_NgayTao='+$scope.convertDate($scope.fr_NgayTao)+'&to_NgayTao='+$scope.convertDate($scope.to_NgayTao),
            }).then(function(response){
                $scope.listDoanhThu=response.data
                $scope.SoDonHang=$scope.listDoanhThu.soDonHang;
                $scope.DoanhThu=$scope.listDoanhThu.doanhThu;
                $scope.SLSanPham=$scope.listDoanhThu.soLuongSP;
            })
        }
    }
    $scope.hideDiv = function($event) {
        var targetId = $event.target.id;
        if (targetId !== 'KQThongKeDoanhThu') {
            $scope.showDiv = false;
        }
    };
    ////////////////////////////////////////////////////////////
    $scope.page = 1;
    $scope.pageSize = 10;
    $scope.listKhach;
    $scope.ThongKeKhach = function(){
        $scope.showDiv_Khach = true;
        if($scope.fr_NgayTao == null || $scope.to_NgayTao == null){
            alert("Vui lòng chọn khoảng thời gian thống kê")
        }
        else{
            $http({
                method:'POST',
                data:{
                    page: $scope.page, 
                    pageSize: $scope.pageSize,
                    TenKhach:$scope.tenkhach,
                    fr_NgayTao:$scope.convertDate($scope.fr_NgayTao),
                    to_NgayTao:$scope.convertDate($scope.to_NgayTao)
                },
                url:current_url+'/api/ThongKe/ThongKeKhach',
            }).then(function(response){
                $scope.listKhach=response.data.data
                console.log($scope.listKhach)
               
            })
        }
        
    }
    $scope.hideDiv_Khach = function($event) {
        var targetId = $event.target.id;
        if (targetId !== 'KQThongKeKhach') {
            $scope.showDiv_Khach = false;
        }
    };
    ///////////////////////////////////////////////////////////////////////////
    $scope.listSPBanChay
    $scope.ThongKeSPBanChay=function(){
        $scope.showDiv_BanChay = true;
        if($scope.fr_NgayTao == null || $scope.to_NgayTao == null){
            alert("Vui lòng chọn khoảng thời gian thống kê")
        }
        else{
            $http({
                method:'POST',
                data:{
                    page: 1, 
                    pageSize: 5,
                    fr_NgayTao:$scope.convertDate($scope.fr_NgayTao),
                    to_NgayTao:$scope.convertDate($scope.to_NgayTao)
                },
                url:current_url+'/api/ThongKe/ThongKe_SP_BanChay',
            }).then(function(response){
                $scope.listSPBanChay=response.data.data
                console.log($scope.listSPBanChay)
               
            })
        }
    }
    $scope.reloadPage=function(){
        window.location.reload();
    }
})