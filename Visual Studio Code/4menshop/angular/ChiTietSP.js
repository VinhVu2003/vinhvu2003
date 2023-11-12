var app = angular.module('ChitietSP',[]);
app.controller("ChitietSPController",function($scope,$http){

  
  $scope.maSP=JSON.parse(localStorage.getItem('contentsmall'))
  console.log($scope.maSP)
  $scope.CTSP={};

  $scope.getProductByID = function () {
    $http.get("https://localhost:44395/api/SanPham/get_by_id?id=" + $scope.maSP).then(
    function (response) {
      $scope.CTSP = response.data;
      
      console.log($scope.CTSP)
    })
  }
  $scope.getProductByID();
})
