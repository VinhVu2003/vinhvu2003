var app = angular.module('TrangChu', []);
app.controller("TrangChuController", function ($scope, $http) {
    $scope.listSanphambanchay;

    $scope.Get_SPBanChay= function () {
        $http({
        method: 'POST',
        data: { page:1, pageSize:8 },
        url: 'https://localhost:44395/api/SanPham/Search_SP_BanChay',
        }).then(function (response) {
        $scope.listSanphambanchay = response.data.data;
        // $scope.totalItems = response.data.totalItems;
        console.log($scope.listSanphambanchay )
        //   $scope.PageIndex(response.data.totalItems)   
        });
    };
    $scope.Get_SPBanChay();
  
    $scope.product=function(x){
        localStorage.setItem('contentsmall',x.maSanPham)
        window.location='chitietsanpham.html'
        // console.log(JSON.parse(localStorage.getItem('contentsmall')))
    }



    $scope.listSanphamNew;

    $scope.Get_SP_New= function () {
        $http({
        method: 'POST',
        data: { page:1, pageSize:8 },
        url: 'https://localhost:44395/api/SanPham/Search_SP_New',
        }).then(function (response) {
        $scope.listSanphamNew = response.data.data;
        // $scope.totalItems = response.data.totalItems;
        console.log($scope.listSanphamNew )
        //   $scope.PageIndex(response.data.totalItems)   
        });
    };
    $scope.Get_SP_New();

})
app.filter('replaceCommaWithDot', function() {
    return function(input) {
      if (!input) return '';
      return input.toString().replace(',', '.');
    };
  });


