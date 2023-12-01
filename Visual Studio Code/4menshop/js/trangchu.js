$(document).ready(function(){
    $('.product-selling-content').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        infinite: true,
        prevArrow:"<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
        nextArrow:"<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"
    });
});
// ----------------------------slideshow-------------------------

var index = 0;
function next(){
    // "./anh/slideshow3.jpg"
    var imgs = ["./anh/slideshow1.jpg","./anh/slideshow3.jpg"]
    document.getElementById('img').src = imgs[index];
    index++;
    if(index==2){
        index=0;
    }
    if(index<0){
        index=0;
    }
}

function prev(){
    
    var imgs = ["./anh/slideshow1.jpg","./anh/slideshow2.jpg","./anh/slideshow3.jpg"]
    document.getElementById('img').src = imgs[index];
    index--;
    if(index<0){
        index=2;
    }
}
setInterval("next()",3000)
// ----------------------------------------------------------------------------

const btn = document.querySelectorAll('.overlayitemicon')
// console.log(btn);
btn.forEach(function(overlayitemicon,index){
    // console.log(overlayitem,index)
    overlayitemicon.addEventListener("click",function(event){{
        // console.log("abc")
        var btnItem = event.target
        
        var product = btnItem.parentElement.parentElement.parentElement.parentElement.parentElement
        console.log(product)
        var productsmall = product.querySelector(".productimgsmall")
        var productImg = productsmall.querySelector("img").src

        var productText = product.querySelector(".producttext") 
        var productName = productText.querySelector("a").innerText

        var productMoney = product.querySelector(".protect-money")
        var productPrice = productMoney.querySelector("p").innerText
        
      //    console.log(productName,productPrice,productImg)
        addcart(productPrice,productName,productImg)
        alert("Thêm giỏ sản phẩm vào giỏ hàng thành công")
        
    }   
    })
})
function addcart(productPrice,productName,productImg){
    var addtr = document.createElement('div.giohang-nho')

    var cartItem = document.querySelectorAll("div.giohang-nho")

    for (var i=0;i<cartItem.length;i++){
        var productT = document.querySelectorAll("span p.title a")
       
        console.log(productT)
        if(productT[i].innerHTML == productName){
            alert("Sản phẩm của bạn đã có trên giỏ hàng")
            return
        }
    }
    var trcontent = productName
    addtr.innerHTML = '<div class="giohang-chung"><div class="giohang-nho" style="width: 100%; height: 120px; background-color: #fff;float: left;box-sizing: border-box;"><div style="width: 85px;height: 113px; background-color: #ff0000;float: left;margin: 3px 0px;"><img class="productImg" src="'+productImg+'" alt="" style="width: 100%; float: left;"></div><div style="width: 70%;height: 50px;float: left;margin-left: 8px;text-align: left;"><span><p class="title" style="font-size: 13px;"><a href="" style="text-decoration: none; color: black;">'+productName+'</a></p></span><div style="display: flex;"><input style="width: 30px; height: 20px; text-align: center;" type="number" value="1"><p class="price" style="margin-left: 15px;margin-top: -6px;">'+productPrice+'</p></div><button class="delete" value="xoa" style="width: 26px;"><i class="fa-solid fa-trash"></i></button></div></div></div>'
    var cartTable = document.querySelector("div.giohang-chung")
    // console.log(cartTable)
    // cartTable.append(addtr)
    cartTable.append(addtr)

    carttotal()
    DeleteCart()
}

// -----------------------total-price--------------------------

function carttotal(){
    var cartItem = document.querySelectorAll("div.giohang-nho")
    var totalC = 0;
    // console.log(cartItem)
    for (var i=0;i<cartItem.length;i++){
        var inputValue = cartItem[i].querySelector("input").value
        // console.log(inputValue)
        var productPrice = cartItem[i].querySelector("p.price").innerHTML
        // console.log(productPrice)

        totalA = inputValue*productPrice*1000
        // totalB = totalA.toLocaleString('de-DE')
        // console.log(totalB)

        totalC = totalC + totalA
        // console.log(totalC)
       
    }

    var carttotalA = document.querySelector(".price-total span")
    carttotalA.innerHTML = totalC.toLocaleString('de-DE')
    inputchange()
    // editValue()
}
// setInterval(()=>{
    //     carttotal()
    // },1000)
    

// function editValue(){
//     var input = document.querySelector("input")
//     // console.log(input)
//     var inputVL = input.value
    
//         input.addEventListener("input",()=>{
//             if(input.value >inputVL){
//                 inputVL=input.value
//                 // console.log(inputVL)
//                 carttotal()
//             }
//             else{
//                 inputVL=input.value
//                 carttotal()
//             }
//             if(inputVL<0){
//                 input.value=0;
//             }
//         })
// }
// editValue()
// -----------------Delete cart--------------------------------
function DeleteCart(){
    var cartItem = document.querySelectorAll("div.giohang-nho")
    for (var i=0;i<cartItem.length;i++){
        var productT = document.querySelectorAll("button.delete")
        productT[i].addEventListener("click",function(event){
            var cartDelete = event.target
            var cartDeleteB = cartDelete.parentElement.parentElement.parentElement
            cartDeleteB.remove()
            carttotal() 
        })
    }
}

//input số lượng
function inputchange(){
    var cartItem = document.querySelectorAll("div.giohang-nho")
    for (var i=0;i<cartItem.length;i++){
        var inputValue = cartItem[i].querySelector("input")
        inputValue.addEventListener("change",function(){
            carttotal()
        })
    }
}

// backtotop
const toTop = document.querySelector(".back-top");
window.addEventListener("scroll",() =>{
    if(window.pageYOffset > 100){
        toTop.classList.add("active");
    }
    else{
        toTop.classList.remove("active")
    }
})


//giohang

// var icon = document.querySelector('.banner2span')
// var content = document.querySelector('.giohang')
// content.style.display='none'
// icon.addEventListener('click',function(){
//     if(content.style.display === 'none'){
//         content.style.display = 'block'
//     }
//     else {
//         content.style.display = 'none'   
//     }

// })


//Search
var icon = document.querySelector('.banner3span')
var Search = document.querySelector('#Search')
icon.addEventListener('click',function(){
    if(Search.style.display === 'none'){
        Search.style.display = 'block'
    }
    else {
        Search.style.display = 'none'   
    }

})