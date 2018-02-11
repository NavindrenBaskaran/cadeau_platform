function addToShoppingCart(product_id){
  var expires = "";
  var shopping_cart_cookie = getShoppingCartCookies();
  var date = new Date();

  date.setTime(date.getTime() + (2*24*60*60*1000))
  expires = "; expires=" + date.toUTCString();

  if (shopping_cart_cookie){
    document.cookie = shopping_cart_cookie + "," + ( product_id || "")  + expires + "; path=/";

  }else{
    document.cookie = "items" + "=" + ( product_id || "")  + expires + "; path=/";
  }
}

function getShoppingCartCookies(){
  var cookies_list = document.cookie.split(";")
  var shopping_cart_cookie = cookies_list.pop()
  return shopping_cart_cookie
}
