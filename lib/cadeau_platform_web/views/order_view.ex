defmodule CadeauPlatformWeb.OrderView do
  use CadeauPlatformWeb, :view

  def format_money(decimal_price_in_string, currency) do
    decimal_price_in_string
    |> Decimal.new
    |> Money.new(currency)
    |> money_to_string
  end

  def format_tax_rate(tax_rate) do
    tax_rate
    |> Decimal.new
    |> Decimal.mult(Decimal.new(100))
  end

  def money_to_string(money) do
    Money.to_string!(money)
  end
end
