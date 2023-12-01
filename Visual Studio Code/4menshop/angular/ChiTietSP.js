var app = angular.module('ChitietSP',[]);
app.controller("ChitietSPController",function($scope,$http){

  $scope.maSP=JSON.parse(localStorage.getItem('contentsmall'))

  $scope.CTSP;
  
  $scope.sizeCode;

  $scope.ProductDetail;
  
  $scope.listSize;
  // $scope.listCart={};

  // $scope.GetAll_Cart = function () {
  //   $http({
  //   method: 'GET',
  //   data: { 
  //   },
  //   url: 'https://localhost:44395/api/GioHang/GetAll',
  //   }).then(function (response) {
  //   $scope.listCart = response.data;
  //   console.log($scope.listCart);
  //   });
  // };
  // $scope.GetAll_Cart = function () {
  //   $http({
  //   method: 'GET',
  //   data: { 
  //   },
  //   url: 'https://localhost:44395/api/GioHang/GetAll',
  //   }).then(function (response) {
  //   $scope.listCart = response.data;
  //   console.log($scope.listCart);
    
  //   });
  // };
  
  

  $scope.getProductByID = function () {
    // $http.get("https://localhost:44395/api/SanPham/get_by_id?id=" + $scope.maSP)
    
    $http({
      method:'GET',
      url:current_url+'sp/get_by_id?id='+ $scope.maSP,
    }).then(
    function (response) {
      $scope.CTSP = response.data; 
       
      $scope.GetSize();
    }).then(function(response){
      // console.log($scope.CTSP)
    })
  }

  $scope.GetSize = function () {
    $http({
    method: 'POST',
    data: { 
      page:1, 
      pageSize:10,
      TenSanPham:$scope.CTSP.tenSanPham,
    },
    url: current_url+'sp/Search_SP_GetAllSize',
    }).then(function (response) {
    $scope.listSize = response.data.data;
    console.log($scope.listSize);
    });
  };
  
  
  $scope.getProductByID();
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // localStorage.clear();
  // $scope.GetAll_Cart();
  
  $scope.getSizeCode = function() {
    // Lấy mã size khi select thay đổi
    $scope.sizeCode = $scope.selectedSize;
    
    $scope.Search();
    // console.log($scope.selectedSize)
    // console.log($scope.sizeCode)
  };
  $scope.Search = function(){
    $http({
      method:'GET',
      data:{
      },
      url:current_url+'sp/Serch_SP_TheoSize?TenSanPham='+$scope.CTSP.tenSanPham+'&MaSize='+$scope.sizeCode,
    }).then(function(response){
      $scope.ProductDetail=response.data;
      console.log($scope.ProductDetail)
    })
  }

  // $scope.cart = function(){
  //   localStorage.setItem('carts',$scope.MaSanPham)
  //   // window.location = 'giohang.html'
  // }
  
  $scope.cart  = function(){
    var listProduct = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
    console.log(listProduct);
    // localStorage.clear();
    var search = listProduct.find(x=>x.name=== $scope.ProductDetail.tenSanPham)
    if(search){
      search.amount++
      search.namesize = $scope.ProductDetail.tenSize
      search.maSP = $scope.ProductDetail.maSanPham
      localStorage.setItem('listProduct',JSON.stringify(listProduct))
      return alert("Sản phẩm đã có trong giỏ hàng!")
    }
    listProduct.push({
        maSP:$scope.ProductDetail.maSanPham,
        img: $scope.ProductDetail.anhDaiDien,
        name: $scope.ProductDetail.tenSanPham,
        price:  $scope.ProductDetail.gia,
        size: $scope.sizeCode,
        namesize: $scope.ProductDetail.tenSize,
        amount:1
    })
    localStorage.setItem('listProduct',JSON.stringify(listProduct));
    
    alert("Thêm vào giỏ hàng thành công!")
  }
  
  


  // $scope.add_cart = function () {
  //   $scope.listCart = $scope.listCart || [];

  //   // Kiểm tra xem maSanPham có tồn tại trong listCart hay không
  //   var isDuplicate = $scope.listCart.some(function(item) {
  //     return item.maSanPham === $scope.CTSP.maSanPham;
  //   });
  
  //   if (isDuplicate) {
  //     // Nếu đã tồn tại, thực hiện hành động phù hợp, ví dụ:
  //     alert("Sản phẩm đã có trong giỏ hàng");
  //   } else {
  //     // Nếu chưa tồn tại, thêm vào listCart
  //     $http({
  //       method: 'POST',
  //       data: { 
  //         maTaiKhoan:'1',
  //         maSanPham:$scope.CTSP.maSanPham,
  //       },
  //       url: 'https://localhost:44395/api/GioHang/Create',
  //     }).then(function (response) {
  //       $scope.listCart = response.data;
  //       alert("Thêm vào giỏ hàng thành công!")
  //     });
  //   }
  // };
  

})
app.filter('replaceCommaWithDot', function() {
  return function(input) {
    if (!input) return '';
    return input.toString().replace(',', '.');
  };
});