var app = angular.module('AppBanHangHDN', []);
app.controller("HoaDonNhapController", function ($scope, $http) {
  
    
    $scope.page = 1;
    $scope.pageSize = 100;
    $scope.listHDN;
    $scope.GetHienThi_HDN= function () {
      $http({
      method: 'POST',
      data: { page: $scope.page, pageSize: $scope.pageSize },
      url: current_url + '/api/HoaDonNhap/HoaDonNhap_Search',
      }).then(function (response) {
      $scope.listHDN = response.data.data;
      console.log($scope.listHDN)
      // $scope.totalItems = response.data.totalItems;
      // $scope.PageIndex(response.data.totalItems)
      });
    };
    $scope.GetHienThi_HDN();
    ///////////////////////////////////////////////////////////////////
    
    $scope.btn_Xem = function(x){
        var div = document.getElementById("ThemSanPham");
        div.style.display = "block";
        $scope.showDiv = true;
        $scope.MaHoaDon=x.maHoaDon;
        // $scope.$watch('MaHoaDon', function(newValue, oldValue) {
        //   if (newValue === '13') {
        //       $scope.displayValue = 'Vũ Đình Vinh';
        //   } else {
        //       $scope.displayValue = newValue;
        //   }
        // });
        $scope.nhaphanphoi=x.maNhaPhanPhoi;
        $scope.kieuthanhtoan=x.kieuThanhToan;
        $scope.tongGia=x.tongTien;
        $scope.ngaytao=x.ngayTao;
        console.log(x.maHoaDon)
        $scope.CTHDN;
        $http({
          method: 'GET',
          // data: { page: $scope.page, pageSize: $scope.pageSize },
          url: current_url + '/api/HoaDonNhap/List_CTHDN_Getbyid?id='+x.maHoaDon,
          }).then(function (response) {
          $scope.CTHDN = response.data;
          console.log($scope.CTHDN)
          
         
          });
    }
    


    $scope.hideDiv = function($event) {
        var targetId = $event.target.id;
        if (targetId !== 'ThemSanPham') {
            $scope.showDiv = false;
        }
    };
})
app.filter('replaceCommaWithDot', function() {
    return function(input) {
      if (!input) return '';
      return input.toString().replace(',', '.');
    };
  });

// app.filter('customFilter', function() {
//     return function(input) {
//         return input === '1' ? 'Vũ Đình Vinh' : input;
//     };
// });