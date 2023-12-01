var icon = document.querySelector('.bt-add')
// console.log(icon)
var content = document.querySelector('.ThemSanPham')
content.style.display='none'

icon.addEventListener('click',function(){
    if(content.style.display === 'none'){
        content.style.display = 'block'
    }
    else {
        content.style.display = 'none'   
    }
})

document.addEventListener('click', function(event) {
    // Kiểm tra xem sự kiện click có xuất phát từ bên trong div giỏ hàng hay không
    if (!content.contains(event.target) && event.target !== icon) {
      // Nếu không, ẩn div giỏ hàng
      content.style.display = 'none';
    }
});

var a =document.getElementsByClassName("baiviet-list");
    a.style.display='none'

document.getElementsByClassName('clickBaiviet').addEventListener('click', function() {
    console.log("a")
    
    // Khi người dùng click vào button, toggle hiển thị của các ul

    const ulList1 = document.getElementById('baiviet-list');
   
    
    if (ulList1.style.display === 'none' ) {
        ulList1.style.display = 'block';
       
    } else {
        ulList1.style.display = 'none';
      
    }
});