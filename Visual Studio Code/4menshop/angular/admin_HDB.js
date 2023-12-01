var app = angular.module('AppBanHangHDB', []);
app.controller("HoaDonBanController", function ($scope, $http) {
  
    $scope.listHDB;
    $scope.listSanPham;
    $scope.list_CTHD;
   
    
  
    $scope.page = 1;
    $scope.pageSize = 100;
  
    $scope.GetHienThi_HDB= function () {
      $http({
      method: 'POST',
      data: { page: $scope.page, pageSize: $scope.pageSize },
      url: current_url + '/api/HoaDonBan/HoaDon_Search',
      }).then(function (response) {
      $scope.listHDB = response.data.data;
      // console.log($scope.listHDB)
      // $scope.totalItems = response.data.totalItems;
      // $scope.PageIndex(response.data.totalItems)
        
      });
    };
  
    $scope.GetHienThiSP= function () {
      $http({
      method: 'POST',
      data: { page: 1, pageSize: 100 },
      url: current_url + '/api/SanPham/search',
      }).then(function (response) {
      $scope.listSanPham = response.data.data;
      // $scope.totalItems = response.data.totalItems;
        // $scope.PageIndex(response.data.totalItems)
      // console.log($scope.listSanPham)
      });
    };

    // $scope.GetKhachHang= function () {
    //   $http({
    //   method: 'POST',
    //   data: { page: 1, pageSize: 100 },
    //   url: current_url + '',
    //   }).then(function (response) {
    //   $scope.listSanPham = response.data.data;
    //   // $scope.totalItems = response.data.totalItems;
    //     // $scope.PageIndex(response.data.totalItems)
    //   // console.log($scope.listSanPham)
    //   });
    // };
      
    $scope.btn_Sua = function (maHoaDon) {
      var modalUpdate = document.getElementById("ThemSanPham");
      // var btn_Them = document.getElementById("btn_Them");
      modalUpdate.style.display = "block";

      var TT = document.getElementById("div_TT");
      TT.style.display = "block";

      var CTHD = document.getElementById("CTHD");
      CTHD.style.display = "block";

      var btnSua = document.getElementById("btnAdd");
      btnSua.style.display = "none";
      
      $http({
          method: 'GET',
          // headers: { "Authorization": 'Bearer ' + _user.token },
          url: current_url + '/api/HoaDonBan/get_by_id?id=' + maHoaDon,
      }).then(function (response) {
       
          let hdb = response.data;
          $scope.maKH = hdb.maKH;
          $scope.MaHoaDon = hdb.maHoaDon;
          $scope.TrangThai = hdb.trangThai;
          $scope.tongGia=hdb.tongGia;
          $scope.ngayTao=hdb.ngayTao;
          $scope.diaChiGiaoHang=hdb.diaChiGiaoHang;
      });
      
      $http({
        method: 'GET',
        // headers: { "Authorization": 'Bearer ' + _user.token },
        url: current_url + '/api/HoaDonBan/List_CTHD_Getbyid?id=' + maHoaDon,
      }).then(function (response) {
        $scope.list_CTHD = response.data;
        // console.log($scope.list_CTHD)
      });
    };

    $scope.MaCTHD;
    $scope.EDIT_CTHD=function(maChiTietHoaDon){
      
      $scope.maSanPham=String(maChiTietHoaDon.maSanPham);
      $scope.soLuong=maChiTietHoaDon.soLuong;
      $scope.tongGiasp=maChiTietHoaDon.tongGia;
      $scope.giamGia=maChiTietHoaDon.giamGia;
      $scope.MaCTHD=maChiTietHoaDon.maChiTietHoaDon;
      console.log($scope.MaCTHD);
    }

    $scope.update_HD_ST1=function(){
      $http({
        method: 'POST',
          // headers: { "Authorization": 'Bearer ' + _user.token },
        data: {
            maHoaDon:$scope.MaHoaDon,
            trangThai:$scope.TrangThai,
            ngayTao: $scope.ngayTao,
            tongGia: $scope.tongGia,
            diaChiGiaoHang:$scope.diaChiGiaoHang,
            maKH: $scope.maKH,
            list_json_ChiTietHD: [{
              maSanPham: $scope.maSanPham,
              soLuong: $scope.soLuong,
              tongGia: $scope.tongGiasp,
              giamGia: $scope.giamGia,
              status:'1',
            }]
        },
        url: current_url + '/api/HoaDonBan/Update_Hoadon',
      })
      .then(function (response) {
        alert("Cập nhật đơn hàng thành công");
        $scope.btn_Sua($scope.MaHoaDon)
        
      }); 
    }
   
    $scope.Update_CTHD_ST2=function(){
      console.log($scope.x)
      $http({
        method: 'POST',
          // headers: { "Authorization": 'Bearer ' + _user.token },
        data: {
            maHoaDon:$scope.MaHoaDon,
            trangThai:$scope.TrangThai,
            ngayTao: $scope.ngayTao,
            tongGia: $scope.tongGia,
            diaChiGiaoHang:$scope.diaChiGiaoHang,
            maKH: $scope.maKH,
            list_json_ChiTietHD: [{
              maChiTietHoaDon:$scope.MaCTHD,
              maHoaDon:$scope.MaHoaDon,
              maSanPham: $scope.maSanPham,
              soLuong: $scope.soLuong,
              tongGia: $scope.tongGiasp,
              giamGia: $scope.giamGia,
              status:'2',
            }]
        },
        url: current_url + '/api/HoaDonBan/Update_Hoadon',
      })
      .then(function (response) {
        alert("Cập nhật đơn hàng thành công");
        $scope.btn_Sua($scope.MaHoaDon)
      }); 
    }

    $scope.x;
    $scope.update_HD_ST3=function(maChiTietHoaDon){
      $scope.x=maChiTietHoaDon;
      console.log($scope.x)
      var result = confirm("Bạn có chắc muốn xóa sản phẩm này không?");
      if(result){
        $http({
          method: 'POST',
            // headers: { "Authorization": 'Bearer ' + _user.token },
          data: {
              maHoaDon:$scope.MaHoaDon,
              trangThai:$scope.TrangThai,
              ngayTao: $scope.ngayTao,
              tongGia: $scope.tongGia,
              diaChiGiaoHang:$scope.diaChiGiaoHang,
              maKH: $scope.maKH,
              list_json_ChiTietHD: [{
                maChiTietHoaDon:$scope.x,
                
                giamGia:'',
                status:'3',
              }]
          },
          url: current_url + '/api/HoaDonBan/Update_Hoadon',
        })
        .then(function (response) {
          console.log(response)
          alert("Cập nhật đơn hàng thành công");
          $scope.btn_Sua($scope.MaHoaDon)
        }); 
      }  
    }

    $scope.AddProduct=function(){
      $http({
        method: 'POST',
          // headers: { "Authorization": 'Bearer ' + _user.token },
        data: {
            trangThai:true,
            ngayTao: new Date(),
            tongGia: $scope.tongGia,
            diaChiGiaoHang:$scope.diaChiGiaoHang,
            maKH: $scope.maKH,
            list_json_ChiTietHD: [{
              maSanPham: $scope.maSanPham,
              soLuong: $scope.soLuong,
              tongGia: $scope.tongGiasp,
              giamGia: $scope.giamGia
            }]
        },
        url: current_url + '/api/HoaDonBan/Create_HoaDon',
      })
      .then(function (response) {
        alert("Thêm đơn hàng thành công!");
        window.location.reload();
      }); 
      
    }

    // $scope.KH_getbyid=function(maKH_TG){
    //   $http({
    //     method: 'GET',
    //     headers: { "Authorization": 'Bearer ' + _user.token },
    //     url: current_url + '/api/Khach/get_by_id?id=' + maKH_TG,
    //   }).then(function (response) {
    //     let KH = response.data;
    //   });
    // }
   
    $scope.Delete = function (maHoaDon) {
      
      var result = confirm("Bạn có chắc muốn xóa sản phẩm này không?");
      if (result) {
        $http({
            method: 'DELETE',                
            // headers: { "Authorization": 'Bearer ' + _user.token },
            url: current_url + '/api/HoaDonBan/HoaDon_Delete?id=' + maHoaDon,
        }).then(function (response) {
         
          alert('Xóa thành công!');
          $scope.GetHienThi_HDB()
        });
    } 
    };
  
    
  
    $scope.ESC = function(){
      var modalUpdate = document.getElementById("ThemSanPham");
      modalUpdate.style.display = "none";
      $scope.submit = "Thêm mới";
      window.location.reload()
    }
    $scope.Nut_Them = function(){
      var modalUpdate = document.getElementById("ThemSanPham");
      modalUpdate.style.display = "block";
      
      var ngaytao = document.getElementById("ngaytao");
      ngaytao.style.display = "none";
      
      var TT = document.getElementById("div_TT");
      TT.style.display = "none";

      var CTHD = document.getElementById("CTHD");
      CTHD.style.display = "none";

      var btnsua = document.getElementById("btnSua");
      btnsua.style.display="none";

    }
  
   
    $scope.GetHienThi_HDB();
    $scope.GetHienThiSP();
    
  })
  
  