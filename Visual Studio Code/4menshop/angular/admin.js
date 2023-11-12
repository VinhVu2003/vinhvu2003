var _user = JSON.parse(localStorage.getItem("user"));
var app = angular.module('AppBanHang', []);
app.controller("SanPhamCtrl", function ($scope, $http) {
  
    $scope.listSanPham;
    $scope.listNhaphanphoi;
    $scope.listChuyenMuc;
    $scope.listSize;
    $scope.submit = "Thêm mới";
    // $scope.GetNameSize;

    $scope.product=function(x){
      localStorage.setItem('contentsmall',x.maSanPham)
      window.location='chitietsanpham.html'
      console.log(x.maSanPham)
    }


    $scope.page = 1;
    $scope.pageSize = 6;
 

  

    $scope.GetHienThiSP= function () {
        $http({
        method: 'POST',
        data: { page: $scope.page, pageSize: $scope.pageSize },
        url: current_url + '/api/SanPham/search',
        }).then(function (response) {
        $scope.listSanPham = response.data.data;
        // $scope.totalItems = response.data.totalItems;
          $scope.PageIndex(response.data.totalItems)
        });
    };

    $scope.PageIndex = function(total){
      var liElements = document.querySelectorAll('.pageElement li');
      liElements.forEach(function (li) {
          li.remove();
      });

      var countPage = Math.ceil((total)/$scope.pageSize)
      
      for (let i = 1; i <= countPage; i++) {
        var li = document.createElement('li')
        li.className= 'page-item'
        var a = document.createElement('a')
        li.appendChild(a)
        a.innerHTML = i
        document.querySelector('.pageElement').appendChild(li)
        li.onclick = function(){
          $scope.changePage(i)
        }
      }
    }

    $scope.changePage = function(i){
      $scope.page = i
      $scope.GetHienThiSP()
    }
    
    $scope.LoadSize= function () {
      $http({
      method: 'POST',
      data: { page: 1, pageSize: 100 },
      url: current_url + '/api/SizeCotroller/Size_Search',
      }).then(function (response) {
      $scope.listSize = response.data.data;
      // console.log($scope.listSize)
      });
    };

    $scope.LoadNhaphanphoi= function () {
        $http({
        method: 'POST',
        data: { page: 1, pageSize: 100 },
        url: current_url + '/api/NhaPhanPhoi/NhaPhanPhoi_Search',
        }).then(function (response) {
        $scope.listNhaphanphoi = response.data.data;
        console.log($scope.listNhaphanphoi)
        });
    };

    $scope.LoadChuyenMuc= function () {
        $http({
        method: 'POST',
        data: { page: 1, pageSize: 100 },
        url: current_url + '/api/ChuyenMuc/ChuyenMuc_Search',
        }).then(function (response) {
        $scope.listChuyenMuc = response.data.data;
        // console.log($scope.listChuyenMuc)
        });
    };

    // $scope.getProductByID = function (id) {
    //     $http.get("https://localhost:44381/api/SanPham/get_by_id?id=" + id).then(
    //       function (response) {
    //         $scope.MaTinTucID = response.data;
    //         console.log(response.data);
    //       },
    //       function (error) {
    //         console.log(error);
    //       }
    //     );
    // }

    // $scope.getNameSizeByID = function (maSize) {
    //   $http.get("https://localhost:44381/api/SizeCotroller/get_by_id?id=" + MaSize).then(
    //     function (response) {
    //       $scope.$scope.GetNameSize = response.data;
    //       console.log($scope.GetNameSize);
    //     },
    //     function (error) {
         
    //     }
    //   );
    // }

    // $scope.Add_San_Pham = function () {
    //     const data = {};
    //     const fileInput = document.querySelector("#upload_Img");
    //     const file = fileInput.files[0];
    //     if (!file) {
    //       alert("Vui lòng chọn hình ảnh tin tức.");
    //       return;
    //     }
    //     if(file){
    //       const formData = new FormData();
    //           formData.append('file', file);
    //           $http({
    //               method: 'POST',
    //               headers: {
    //                   "Authorization": 'Bearer ' + _user.token,
    //                   'Content-Type': undefined
    //               },
    //               data: formData,
    //               url:'https://localhost:44381/api/UpLoad_/upload',
    //           }).then(function (res) {
    //             $scope.AnhDaiDien = res.data.filePath
    //             console.log($scope.AnhDaiDien)
    //             $http({
    //                     method: "POST",
    //                     url: "https://localhost:44381/api/SanPham/San_Pham_Create",
    //                     data: {
    //                       TenSanPham: $scope.tenSanPham,
    //                       MaChuyenMuc: $scope.maChuyenMuc,
    //                       Gia: $scope.gia,
    //                       MaSize: $scope.maSize,
    //                       SoLuong: $scope.soLuong,
    //                       AnhDaiDien: "./anh/"+$scope.AnhDaiDien,
    //                     },
                        
    //                   })
    //                     .then(function (response) {
    //                       alert("Thêm sản phẩm thành công!");
    //                       $scope.GetHienThiSP();
    //                       window.location='./admin.html'
    //                     })
    //                     .catch(function (error) {
    //                       console.log(error);
    //                     });
    //                     console.log(data)
    //           })
    //     }
    // };

    // $scope.UPdate_SanPham=function(){
    //   // const data = {
    //   //   MaSanPham:$scope.DT_MaSanPham,
    //   //   tenSP:tenSanPham,
    //   //   MaChuyenMuc:maChuyenMuc,
    //   //   Gia:gia,
    //   //   MaSize:maSize,
    //   //   SoLuong:soLuong,
    //   //   AnhDaiDien:""
    //   // };
    //   const fileInput = document.querySelector("#upload_Img");
    //   const file = fileInput.files[0];
    //   if (!file) {
    //     alert("Vui lòng chọn hình ảnh san pham.");
    //     return;
    //   }
    //   if(file){
    //     const formData = new FormData();
    //     formData.append('file', file);
    //         $http({
    //             method: 'POST',
    //             headers: {
    //                 // "Authorization": 'Bearer ' + _user.token,
    //                 'Content-Type': undefined
    //             },
    //             data: formData,
    //             url:'https://localhost:44381/api/UpLoad_/upload',
    //         }).then(function (res) {
    //           $scope.AnhDaiDien = res.data.filePath
    //           // console.log($scope.AnhDaiDien)
    //           $http({
    //                   method: "PUT",
    //                   url: "/api/NhaPhanPhoi/PhaPhanPhoi_Update ",
    //                   data: {
    //                     MaSanPham:$scope.DT_MaSanPham,
    //                     TenSanPham: $scope.tenSanPham,
    //                     MaChuyenMuc: $scope.maChuyenMuc,
    //                     Gia: $scope.gia,
    //                     MaSize: $scope.maSize,
    //                     SoLuong: $scope.soLuong,
    //                     AnhDaiDien: "./anh/"+$scope.AnhDaiDien,
    //                   },
                      
    //                 })
    //                   .then(function (response) {
    //                     alert("Sua sản phẩm thành công!");
    //                     $scope.GetHienThiSP();
    //                     window.location='./admin.html'
    //                   })
    //                   .catch(function (error) {
    //                     console.log(error);
    //                   });
    //                   // console.log(data)
    //         })
    //   }
    // }

    

    // $scope.DT_MaSanPham;
   
    $scope.btn_Sua = function (maSanPham) {
      $scope.submit = "Lưu lại";
      var modalUpdate = document.getElementById("ThemSanPham");
      var btn_Them = document.getElementById("btn_Them");
      modalUpdate.style.display = "block";
      $scope.anhDaiDien=maSanPham.anhDaiDien;
      $http({
          method: 'GET',
          // headers: { "Authorization": 'Bearer ' + _user.token },
          url: current_url + '/api/SanPham/get_by_id?id=' + maSanPham.maSanPham,
      }).then(function (response) {
          let sanpham = response.data;
          $scope.maSanPham = sanpham.maSanPham;
          $scope.tenSanPham = sanpham.tenSanPham;
          $scope.maChuyenMuc = sanpham.maChuyenMuc + '';
          $scope.gia = sanpham.gia;
          $scope.maSize = sanpham.maSize + '';
          $scope.soLuong = sanpham.soLuong;

      });
    };
    
    $scope.Save = function () {
      const fileInput = document.querySelector("#upload_Img");
      const file = fileInput.files[0];
      if (file) {
        const formData = new FormData();
        formData.append('file', file);
        $http({
            method: 'POST',
            headers: {
                // "Authorization": 'Bearer ' + _user.token,
                'Content-Type': undefined
            },
            data: formData,
            url:'https://localhost:44381/api/UpLoad_/upload',
          }).then(function (res) {
              $scope.AnhDaiDien = res.data.filePath
              if ($scope.submit == "Thêm mới") {
                  $http({
                      method: 'POST',
                      // headers: { "Authorization": 'Bearer ' + _user.token },
                      data: {
                        TenSanPham: $scope.tenSanPham,
                        MaChuyenMuc: $scope.maChuyenMuc,
                        Gia: $scope.gia,
                        MaSize: $scope.maSize,
                        SoLuong: $scope.soLuong,
                        anhDaiDien: "./anh"+$scope.AnhDaiDien,
                      },
                      url: current_url + '/api/SanPham/San_Pham_Create',
                  }).then(function (response) {
                      window.location.reload()
                      $scope.GetHienThiSP();
                      alert('Thêm sản phẩm thành công!');
                      
                  });
              } else {
                  $http({
                      method: 'PUT',
                      // headers: { "Authorization": 'Bearer ' + _user.token },
                      data: {
                        MaSanPham:$scope.maSanPham,
                        TenSanPham:$scope.tenSanPham,
                        MaChuyenMuc:$scope.maChuyenMuc,
                        MaSize:$scope.maSize,
                        AnhDaiDien:"./anh"+$scope.AnhDaiDien,
                        SoLuong:$scope.soLuong,
                        Gia:$scope.gia
                      },
                      url: current_url + '/api/SanPham/SanPham_Update',
                  }).then(function (response) {
                    window.location.reload();
                      $scope.GetHienThiSP();
                      alert('Cập nhật sản phẩm thành công!');
                  });
              }
          });
      } else {
          // obj.sanpham.anhDaiDien = $scope.anhDaiDien;
          if ($scope.submit == "Thêm mới") {
              $http({
                  method: 'POST',
                  // headers: { "Authorization": 'Bearer ' + _user.token },
                  data: {
                    TenSanPham: $scope.tenSanPham,
                    MaChuyenMuc: $scope.maChuyenMuc,
                    Gia: $scope.gia,
                    MaSize: $scope.maSize,
                    SoLuong: $scope.soLuong,
                    AnhDaiDien: "./anh"+$scope.AnhDaiDien,
                  },
                  url: current_url + '/api/SanPham/San_Pham_Create',
              }).then(function (response) {
                window.location.reload()
                $scope.GetHienThiSP();
                alert('Thêm sản phẩm thành công!');
              });
          } else {
              $http({
                  method: 'PUT',
                  // headers: { "Authorization": 'Bearer ' + _user.token },
                  data: {
                    MaSanPham:$scope.maSanPham,
                    TenSanPham:$scope.tenSanPham,
                    MaChuyenMuc:$scope.maChuyenMuc,
                    MaSize:$scope.maSize,
                    AnhDaiDien:$scope.AnhDaiDien,
                    SoLuong:$scope.soLuong,
                    Gia:$scope.gia
                  },
                  url: current_url + '/api/SanPham/SanPham_Update',
              }).then(function (response) {
                window.location.reload()
                $scope.GetHienThiSP();
                alert('Cập nhật sản phẩm thành công!');
              });
          }
      }
    };
    
    

    $scope.Sanpham_Delete = function (MaSanPham) {
        
      
        var result = confirm("Bạn có chắc muốn xóa sản phẩm này không?");
        if (result) {
        $http
        .delete("https://localhost:44381/api/SanPham/San_Pham_Delete?ID=" + MaSanPham)

        .then(
          function (response) {
            // console.log(result)
            $http({
              method: 'POST',
              data: { page: 1, pageSize: 10 },
              url: current_url + '/api/SanPham/search',
              })
            
            .then(
              function (response) {
                $scope.listSanPham = response.data.data;
                alert("Xóa sản phẩm thành công");
              },
              function (error) {
                console.log(error);
              }
            );
          },
          function (error) {
            console.log(error);
          }
        );
        }
    };
    $scope.ESC = function(){
      var modalUpdate = document.getElementById("ThemSanPham");
      modalUpdate.style.display = "none";
      $scope.submit = "Thêm mới";
    }
    $scope.Nut_Them = function(){
      $scope.tenSanPham="";
      $scope.maChuyenMuc="";
      $scope.gia="";
      $scope.maSize="";
      $scope.soLuong="";
      $scope.anhDaiDien="";
  
      var nut = document.getElementById("btn_Them");
      var modalUpdate = document.getElementById("ThemSanPham");
      var btn_Sua = document.getElementById("btn_Sua");
  
      modalUpdate.style.display = "block";
     
      nut.style.display="block";
      btn_Sua.style.display="none";
    }
    $scope.GetHienThiSP()
    $scope.LoadNhaphanphoi()
    $scope.LoadSize()
    $scope.LoadChuyenMuc()
   

  
})
///////////////////////////////////////////////////////////////////////////////////////////////////////
app.controller("NhaPhanPhoiCtrl", function ($scope, $http) {
  
  $scope.listNhaphanphoi;
  $scope.LoadNhaphanphoi= function () {
      $http({
      method: 'POST',
      data: { page: 1, pageSize: 100 },
      url: current_url + '/api/NhaPhanPhoi/NhaPhanPhoi_Search',
      }).then(function (response) {
      $scope.listNhaphanphoi = response.data.data;
      console.log($scope.listNhaphanphoi)
      });
  };

  $scope.NhaPhanPhoi_ADD = function () {
    const data = {};
    $http({
      method: "POST",
      url: current_url + '/api/NhaPhanPhoi/NhaPhanPhoi_Create',
      data: {
        TenNhaPhanPhoi: $scope.Ten_NPP,
        DiaChi: $scope.DC_NPP,
        SoDienThoai: $scope.SDT_NPP,
      }
    })
    .then(function (response) {
      $scope.LoadNhaphanphoi();
      alert('Thêm sản phẩm thành công!');
      })
  }
  

  $scope.NhaPhanPhoi_Delete = function (MaNhaPhanPhoi) {
    
    var result = confirm("Bạn có chắc muốn xóa sản phẩm này không?");
    if (result) {
      $http({
          method: 'DELETE',                
          // headers: { "Authorization": 'Bearer ' + _user.token },
          url: current_url + '/api/NhaPhanPhoi/PhaPhanPhoi_Delete?id=' + MaNhaPhanPhoi,
      }).then(function (response) {
        alert('Xóa thành công!');
        $scope.LoadNhaphanphoi()
      });
  } 
  };

  // $scope.getNPPByID = function (maNhaPhanPhoi) {
  //   $http.get("https://localhost:44381/api/NhaPhanPhoi/PhaPhanPhoi_GetID?id=" + maNhaPhanPhoi).then(
  //     function (response) {
  //       $scope.maNhaPhanPhoi = response.data;
  //       console.log($scope.maNhaPhanPhoi)
  //     },
  //     function (error) {
  //     }
  //   );
    
  // };
  
  $scope.MaNPP;
  $scope.EditNPP = function (maNhaPhanPhoi) {
   
    $http
      .get(`https://localhost:44381/api/NhaPhanPhoi/PhaPhanPhoi_GetID?id=${maNhaPhanPhoi}`)
      .then(function (response) {
        $scope.selectNPP = response.data;
        // Mở modal để cập nhật thông tin sản phẩm và hiển thị dữ liệu sản phẩm trong modal
        console.log($scope.selectNPP);

        $scope.Ten_NPP = $scope.selectNPP.tenNhaPhanPhoi
        $scope.DC_NPP = $scope.selectNPP.diaChi
        $scope.SDT_NPP= $scope.selectNPP.soDienThoai
        $scope.MaNPP=$scope.selectNPP.maNhaPhanPhoi
      });
  };
  
  $scope.edit = function (maNhaPhanPhoi) {
    var modalUpdate = document.getElementById("ThemSanPham");
    var btn_Sua = document.getElementById("btn_Sua");
    var btn_Them = document.getElementById("btn_Them");
    modalUpdate.style.display = "block";
    btn_Sua.style.display="block";
    btn_Them.style.display="none";
    
    
    $scope.EditNPP(maNhaPhanPhoi); // Gọi hàm EditProduct với mã sản phẩm để tải dữ liệu sản phẩm
  
    var closeModalUpdateBtn = document.getElementById("esc");
  
    //   closeModalUpdateBtn.onclick = function () {
    //   modalUpdate.style.display = "none";
    //   // overlayUpdate.style.display = "none";
    // };
  };
  
  $scope.Nut_Them = function(){
    $scope.Ten_NPP="";
    $scope.DC_NPP="";
    $scope.SDT_NPP="";

    var nut = document.getElementById("btn_Them");
    var modalUpdate = document.getElementById("ThemSanPham");
    var btn_Sua = document.getElementById("btn_Sua");

    modalUpdate.style.display = "block";
    nut.style.display="block";
    btn_Sua.style.display="none";
  }

  $scope.ESC = function(){
    var modalUpdate = document.getElementById("ThemSanPham");
    modalUpdate.style.display = "none";
  }

  $scope.NhaPhanPhoi_Update = function () {
    $http({
      method: "PUT",
      url: current_url + '/api/NhaPhanPhoi/PhaPhanPhoi_Update',
      data: {
        MaNhaPhanPhoi: $scope.MaNPP,
        TenNhaPhanPhoi: $scope.Ten_NPP,
        DiaChi: $scope.DC_NPP,
        SoDienThoai: $scope.SDT_NPP,
      }
    }).then(
        function (response) {
          alert("Sửa nhà phân phối thành công");
          $scope.LoadNhaphanphoi();
        },
        function (response) {
          alert("Lỗi");
        }
      );
   
  };
  $scope.LoadNhaphanphoi()
  
  
})

////////////////////////////////////////////////////////////////////////////////////////////////////////
app.controller("ChuyenMucController", function($scope,$http){
  $scope.submit="Thêm mới"
  $scope.ESC=function(){
    var a=document.getElementById("ThemSanPham");
    a.style.display="none";
    $scope.submit="Thêm mới"

  }
  $scope.btn_ADD=function(){
    var a=document.getElementById("ThemSanPham")
    a.style.display="block";
  }

})
////////////////////////////////////////////////////////////////////































// var icon = document.querySelector('.bt-add')
// var content = document.querySelector('#ThemSanPham')

// var icon2 = document.querySelector('.fa-x')

// content.style.display='none'

// var icon3 = document.querySelector('.sua')

// icon.addEventListener('click',function(){
//     if(content.style.display = 'none'){
//         content.style.display = 'block'

//     }
// })
// icon2.addEventListener('click',function(){
//   if(content.style.display === 'block'){
//       content.style.display = 'none'
//   }

// })





