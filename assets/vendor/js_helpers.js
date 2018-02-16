function addToShoppingCart(product_id){
  var expires = "";
  var shopping_cart_cookie = getShoppingCartCookies();
  var date = new Date();

  date.setTime(date.getTime() + (2*24*60*60*1000))
  expires = "; expires=" + date.toUTCString();

  if (shopping_cart_cookie){
    document.cookie = shopping_cart_cookie + ":" + ( product_id || "")  + expires + "; path=/";
  }else{
    document.cookie = "items" + "=" + ( product_id || "")  + expires + "; path=/";
  }
  updateselectedItemsCount()
}

function updateselectedItemsCount(){
  var $itemCount = $("#itemCount");
  if (selectedItems()) {
    $itemCount.html(selectedItems().length);
  }else{
    $itemCount.html(0);
  }
}

function selectedItems(){
  var $itemCount = $("#itemCount");
  var shopping_cart_cookie = getShoppingCartCookies();
  if (shopping_cart_cookie){
    var items = shopping_cart_cookie.split("=")[1].split(":")
    return Array.from(new Set(items))
  }else{
    []
  }
}

function getShoppingCartCookies(){
  var cookies_list = document.cookie.split(";")
  var shopping_cart_cookie = cookies_list.pop()
  return shopping_cart_cookie
}

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
    }else{
      alert("Failed to Add Item")
    }
  });
}
