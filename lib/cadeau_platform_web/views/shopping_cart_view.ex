defmodule CadeauPlatformWeb.ShoppingCartView do
  use CadeauPlatformWeb, :view

  def total_cart_value(product_lines) do
    Enum.reduce product_lines, Money.new(0, :MYR), fn(product_line, acc) ->
      Money.add(acc, Money.multiply(product_line.product.price_cents, product_line.quantity))
    end
  end

  def shopping_line_product_price(price, quantity) do
    Money.multiply(price, quantity)
  end

  def zero_money() do
    Money.new(0, :MYR) 
  end
end
