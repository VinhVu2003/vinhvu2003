var app = angular.module('TrangChu', []);

app.controller("TrangChuController", function ($scope, $http) {
    $scope.listSanphambanchay;


    $scope.Get_SPBanChay= function () {
        $http({
        method: 'POST',
        data: { page:1, pageSize:8 },
        
        url:current_url+'sp/search'
        
        }).then(function (response) {
        $scope.listSanphambanchay = response.data.data;
        // $scope.totalItems = response.data.totalItems;
        // console.log($scope.listSanphambanchay )
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
        // url: current_url+'/api/SanPham/Search_SP_New',
        url:current_url+'sp/Search_SP_New'
        }).then(function (response) {
        $scope.listSanphamNew = response.data.data;
        // $scope.totalItems = response.data.totalItems;
        // console.log($scope.listSanphamNew )
        //   $scope.PageIndex(response.data.totalItems)
        });
    };

    $scope.Get_SP_New();
    /////////////////////////////////////////////////////////////////////////////////////////////////////////

    $scope.chuyenmuc_aosomi = function(){
        localStorage.setItem('chuyenmuc',1);
        window.location='aonam.html'
    }
    $scope.chuyenmuc_aothun = function(){
        localStorage.setItem('chuyenmuc',2);
        window.location='aonam.html'
    }
    $scope.chuyenmuc_aopolo = function(){
        localStorage.setItem('chuyenmuc',3);
        window.location='aonam.html'
    }
    $scope.chuyenmuc_aokhoac = function(){
        localStorage.setItem('chuyenmuc',4);
        window.location='aonam.html'
    }
    $scope.chuyenmuc_aolen = function(){
        localStorage.setItem('chuyenmuc',5);
        window.location='aonam.html'
    }
    $scope.chuyenmuc_aovest = function(){
        localStorage.setItem('chuyenmuc',6);
        window.location='aonam.html'
    }
    $scope.chuyenmuc_aoghile = function(){
        localStorage.setItem('chuyenmuc',7);
        window.location='aonam.html'
    }

    $scope.checkEnterKey  = function(event) {
        if (event.keyCode === 13) {
            // Xử lý khi phím Enter được ấn
            // Ví dụ: Gọi hàm tìm kiếm hoặc thực hiện hành động mong muốn
            // Lấy dữ liệu từ trường input
            var dataToSave = $scope.inputData;

            // Lưu dữ liệu vào localStorage
            localStorage.setItem('savedData', dataToSave);
            
            // Xóa dữ liệu trong trường input sau khi lưu vào localStorage (nếu muốn)
            // $scope.inputData = '';

            // Thông báo hoặc thực hiện hành động khác sau khi lưu dữ liệu
            alert('Dữ liệu đã được lưu vào localStorage: ' + dataToSave);
            window.location='SanPham_Search.html'
        }
    };
})
app.filter('replaceCommaWithDot', function() {
    return function(input) {
      if (!input) return '';
      return input.toString().replace(',', '.');
    };
  });


