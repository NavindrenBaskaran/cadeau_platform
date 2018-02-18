defmodule CadeauPlatformWeb.ShoppingCartView do
  use CadeauPlatformWeb, :view

  def total_cart_value(product_lines) do
   total = Enum.reduce product_lines, Money.new(:MYR, 0), fn(product_line, acc) ->
            Money.add!(acc,  Money.mult!(product_line.product.price, product_line.quantity))
           end
   money_to_string(total)
  end

  def shopping_line_product_price(price, quantity) do
    money_to_string(Money.mult!(price, quantity))
  end

  def zero_money() do
    money_to_string(Money.new(0, :MYR))
  end

  def money_to_string(money) do
    Money.to_string!(money)
  end
end
