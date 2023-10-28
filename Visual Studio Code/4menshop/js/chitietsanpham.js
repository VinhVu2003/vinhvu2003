function changeImage(id){
    let imgParth=document.getElementById(id).getAttribute('src');
    document.getElementById('img-main').setAttribute('src', imgParth);
}


// $(document).ready(function(){
//     $('.product-selling-content').slick({
//         slidesToShow: 4,
//         slidesToScroll: 1,
//         infinite: true,
//         prevArrow:"<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
//         nextArrow:"<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"
//     });
// });
