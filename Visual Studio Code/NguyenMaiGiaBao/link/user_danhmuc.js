var app = angular.module('AppBanHang', []);

app.controller("DanhMucCtrl", function ($scope, $http) {
    $scope.listSanPhamAll;
    $scope.listCMAll;

    $scope.GetSanPham = function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPham/get-cm',
        }).then(function (response) {
            $scope.listSanPhamAll = response.data;
        });
    };
    $scope.GetSanPham();
    $scope.GetChuyenMuc = function () {
        $http({
            method: 'GET',
            url: current_url + '/api/ChuyenMuc/get-all',
        }).then(function (response) {
            $scope.listCMAll = response.data;
        });
    };
    $scope.GetSanPham();
    $scope.GetChuyenMuc();
    $scope.danhmuc = function(x){
        localStorage.setItem('productDetail',x.maSanPham)
        window.location = 'chitietsp.html'
    }
    
    $scope.XoaSanPhamNhieu = function () {
        var selectedSanPhams = $scope.listSanPhamAll.filter(function (x) {
            return x.selected;
        });
    
        var selectedMaSanPhams = selectedSanPhams.map(function (x) {
            return x.maSanPham;
        });
    
        if (selectedMaSanPhams.length === 0) {
            alert("Vui lòng chọn ít nhất một danh mục để hiện.");
            return;
        }
    
        // Chuyển danh sách mã sản phẩm thành chuỗi dạng '1,2,3'
        var maSanPhamString = selectedMaSanPhams.join(',');
    
        var result = confirm("Bạn có thực sự muốn xóa các sản phẩm đã chọn không?");
        if (result) {
            $http({
                method: 'GET',
                //headers: { "Authorization": 'Bearer ' + _user.token },
                url: current_url + '/api/SanPham/get-cm',
                data: { MaSanPham: maSanPhamString },
                headers: { 'Content-type': 'application/json' }
            }).then(function (response) {
                $scope.LoadSanPham();
                alert('Xóa thành công!');
                debugger
            });
    
        }
    };



});


