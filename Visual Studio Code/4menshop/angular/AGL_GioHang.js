var app = angular.module('GioHang',[]);
app.controller("GioHangController",function($scope,$http){

    // function Product(){
    //     $scope.listItemBuy = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
    //     var body = $('.parentListCart')
    //     var content =''
    //     $scope.listItemBuy.map(function(value,index){
    //         return content+= `<tr id="listCart" >
    //                             <td style="padding: 5px;"><img src="${value.img}" style="width: 50px;"></td>
    //                             <td ><p><span class="TTSP">${value.name}</span></p></td>
    //                             <td style="display: flex;margin-top: 20px;">
                                    
    //                                 <div ><button onclick="tangsl(${index})"  style=" width: 18px;" class="tang" type="button">+</button></div>
    //                                 <input style="text-align: center;"  class="sl" type="text" value="${value.amount}" min="0" >
    //                                 <div ><button ng-click="giamsl($index)" style=" width: 18px;" class="giam" type="button">-</button></div>
    //                             </td>
                                
    //                             <td>
    //                                 <select name="" id="" class="size" ng>
    //                                     <option value="${value.size}">${value.namesize}</option>
    //                                 </select>
    //                             </td>
    //                             <td> <p><span class="gia">${value.price}</span></p></td>
    //                             <td><button onclick="deleteProduct(${index})" class="xoa">Xóa</button></td>
    //                         </tr>`
    //     })
        
    //     body.append(content)
    //     // total()
    //     tongtien()
    // }
    // Product()

    $scope.listItemBuy = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
    console.log($scope.listItemBuy)
    $scope.giamsl=function(value){
        
        // var listProductLocal = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
        // var amount = listProductLocal[index].amount
        // if(amount>1){
        //     amount--
        //     listProductLocal[index].amount = amount
        //     localStorage.setItem('listProduct',JSON.stringify(listProductLocal))
        //     Product()
        //     tongtien()
        // }
    }
    $scope.tinhTongTien = function() {
        var tongTien = 0;
        angular.forEach($scope.listItemBuy, function(item) {
            tongTien += item.amount * item.price;
        });
        return tongTien;
    };
    $scope.tinhTongTien();
    // $scope.Tongtien=function(){
    //     var sum = 0
        
    //     var listProductLocal = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
    //     listProductLocal.map(function(item){
    //         var soluong = item.amount
    //         var gia = item.price
    //         sum += soluong*gia
    //     })
    //     var tongcong = document.querySelector(".tongcong span")
    //     tongcong.innerHTML = sum
    //     localStorage.setItem('listProduct',JSON.stringify(listProductLocal))
    //     console.log($scope.listItemBuy)
    //     $scope.tongtien;
    //     $scope.listItemBuy.forEach(x =>{
    //         $scope.tongtien += x.amount*x.price
    //     })
    //     console.log($scope.tongtien);
    // }
    // $scope.Tongtien();
   
    // deleteProduct = function(id){
    //     var listItemBuy = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
    //     listItemBuy.splice(id,1)
    //     localStorage.setItem('listProduct',JSON.stringify(listItemBuy))
    //     window.location.reload()
    // }
    $scope.xoaSanPham = function(maSP) {
        for (var i = 0; i < $scope.listItemBuy.length; i++) {
            if ($scope.listItemBuy[i].maSP === maSP) {
                $scope.listItemBuy.splice(i, 1);
                localStorage.setItem('listProduct', JSON.stringify($scope.listItemBuy));
                break;
            }
        }
    };
    
    // function tangsl(index){
    //     var listProductLocal = localStorage.getItem('listProduct')? JSON.parse(localStorage.getItem('listProduct')):[]
    //     var amount = listProductLocal[index].amount
    //     amount++
    //     listProductLocal[index].amount = amount
    //     localStorage.setItem('listProduct',JSON.stringify(listProductLocal))
    //     Product()
    //     tongtien()
        
    // }
    $scope.tangsl = function(index) {
        var listProductLocal = JSON.parse(localStorage.getItem('listProduct')) || [];
        if (listProductLocal[index]) {
            listProductLocal[index].amount++;
            localStorage.setItem('listProduct', JSON.stringify(listProductLocal));
            $scope.listItemBuy = listProductLocal; // Cập nhật lại scope
            $scope.getListCTHSB();
        }
    };

    $scope.giamsl = function(index) {
        var listProductLocal = JSON.parse(localStorage.getItem('listProduct')) || [];
        if (listProductLocal[index] && listProductLocal[index].amount>1) {
            listProductLocal[index].amount--;
            localStorage.setItem('listProduct', JSON.stringify(listProductLocal));
            $scope.listItemBuy = listProductLocal; // Cập nhật lại scope
        }
    };

    // console.log( $scope.listItemBuy)
    $scope.getListCTHSB=function()
    {
        $scope.listCTHDB=[]
        $scope.listItemBuy.forEach(x => {
            var obj={
               
                "maSanPham": x.maSP,
                "soLuong": x.amount,
                "tongGia": x.amount*x.price,
                "giamGia": "không có",
                "status": 0
            }
            $scope.listCTHDB.push(obj)
        });
    }
    $scope.getListCTHSB()

    
    
    

    $scope.CreateHD=function(){
        console.log($scope.tenKH)
        console.log($scope.sdt)
        console.log($scope.diaChi)
        console.log($scope.tongtien)
        $http({
            method: 'POST',
            //   headers: { "Authorization": 'Bearer ' + _user.token },
            data: {
                tenKH:$scope.tenKH,
                diaChi:$scope.diaChi,
                sdt:$scope.sdt,  

                trangThai:true,
                ngayTao:new Date(),
                diaChiGiaoHang:$scope.diaChi,
                tongGia:$scope.tinhTongTien(),
                list_json_ChiTietHD:$scope.listCTHDB
                
            },
            url:  current_url+'dathang/Create',
          })
          .then(function (response) {  
            console.log(response)
            alert("Thêm đơn hàng thành công")
            localStorage.removeItem('listProduct');
            // window.location.reload();
        });
        
       
    }

    
})

