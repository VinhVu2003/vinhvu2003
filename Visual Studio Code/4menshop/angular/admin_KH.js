var app = angular.module('AppBanHangKH', []);
app.controller("KhachHangController", function ($scope, $http) {

    $scope.listKH;
    $scope.page = 1;
    $scope.pageSize = 10;

    $scope.submit="Thêm mới"
    $scope.GetHienThiKH= function () {
        $http({
        method: 'POST',
        data: { page: $scope.page, pageSize: $scope.pageSize },
        url: current_url + '/api/Khach/search',
        }).then(function (response) {
        $scope.listKH = response.data.data;
        console.log($scope.listKH)
        // $scope.totalItems = response.data.totalItems;
        //   $scope.PageIndex(response.data.totalItems)
        });
    };

    $scope.KH_Delete = function (a) {
        var result = confirm("Bạn có chắc muốn xóa sản phẩm này không?");
        if (result) {
          $http({
              method: 'DELETE',                
              // headers: { "Authorization": 'Bearer ' + _user.token },
              url: current_url + '/api/Khach/Delete_KH?id=' + a,
          }).then(function (response) {
           
            alert('Xóa thành công!');
            $scope.GetHienThiKH()
          });
      } 
    };

    $scope.btn_Sua = function (KH) {
        var a = document.getElementById("btnsua");  
        a.style.display = "block";
        
        var modalUpdate = document.getElementById("ThemSanPham");
        modalUpdate.style.display = "block";     
        $scope.submit = "Lưu lại"; 

        $scope.MaKH=KH.maKH;
        $scope.TenKH=KH.tenKH;
        $scope.DiaChi=KH.diaChi;
        $scope.SDT=KH.sdt;

    }

    $scope.Save=function(){
        
        $http({
            method: 'POST',
              // headers: { "Authorization": 'Bearer ' + _user.token },
            data: {
                tenKH:$scope.TenKH,
                diaChi:$scope.DiaChi,
                sdt:$scope.SDT,
            },
            url: current_url + '/api/Khach/Create',
          })
          .then(function (response) {
            alert("Thêm khách hàng thành công!");
            window.location.reload();
        }); 
    }
    $scope.UpDate=function(){
        
        $http({
            method: 'POST',
              // headers: { "Authorization": 'Bearer ' + _user.token },
            data: {
                maKH:$scope.MaKH,
                tenKH:$scope.TenKH,
                diaChi:$scope.DiaChi,
                sdt:$scope.SDT,
            },
            url: current_url + '/api/Khach/Update_KH',
          })
          .then(function (response) {
            alert("Cập nhật khách hàng thành công");
            window.location.reload();
        }); 
    }


    

    $scope.GetHienThiKH();



    $scope.ESC = function(){
        var modalUpdate = document.getElementById("ThemSanPham");
        modalUpdate.style.display = "none";
        $scope.submit = "Thêm mới";
    }
    
    $scope.Nut_Them = function(){
        $scope.MaKH="";
        $scope.TenKH="";
        $scope.DiaChi="";
        $scope.SDT="";
        var modalUpdate = document.getElementById("ThemSanPham");  
        modalUpdate.style.display = "block";

        var a = document.getElementById("btn_them");  
        a.style.display = "block";
    }

})