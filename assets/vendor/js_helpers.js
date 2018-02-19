function addItemToCart(product_id){
  var csrf = $('input[name=csrf_token]')[0].value
  $.ajax({
    method: "POST",
    url: "shopping_cart/add",
    data: {product_id: product_id, _csrf_token: csrf}
  }).done(function(msg){
    var msg = JSON.parse(msg)
    if (msg.status == 200){
      alert("Item Added");
    }else if(msg.status == 500){
      alert("Something went wrong.")
    }else {
      alert("Should Login First.")
    }
  });
}
