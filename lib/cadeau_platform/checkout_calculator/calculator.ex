defmodule CadeauPlatform.CheckoutCalculator.Calculator do
  def total_order_amount(product_lines) do
    Enum.reduce product_lines, Money.new(0, :MYR), fn(product_line, acc) ->
      total = Money.mult!(product_line.product.price, product_line.quantity)
      tax_rate = get_tax_rate(product_line.product)

      total
      |> Money.mult!(tax_rate)
      |> round_tax_amount
      |> Money.add!(total)
      |> Money.add!(acc)
    end
  end

  def total_sales_tax_amount(product_lines) do
    Enum.reduce product_lines, Money.new(0, :MYR), fn(product_line, acc) ->
      quantity = product_line.quantity
      total = product_line.product.price |> Money.mult!(quantity)
      tax_rate = get_tax_rate(product_line.product)

      total
      |> Money.mult!(tax_rate)
      |> round_tax_amount
      |> Money.add!(acc)
    end
  end

  def payable_per_product(product_lines) do
    Enum.map(product_lines, fn(product_line) ->
      quantity = product_line.quantity
      tax_rate = get_tax_rate(product_line.product)

      total = Money.mult!(product_line.product.price, quantity)
      total_sales_tax = Money.mult!(total, tax_rate)
      total_sales_tax_amount_rounded = round_tax_amount(total_sales_tax)
      total_with_sales_tax = Money.add!(total, total_sales_tax_amount_rounded)

      %{name: product_line.product.name, quantity: quantity, product_price: Money.to_decimal(product_line.product.price), total_tax_rate: tax_rate, total: Money.to_decimal(total), sales_tax: Money.to_decimal(total_sales_tax_amount_rounded), total_with_sales_tax: Money.to_decimal(total_with_sales_tax), currency: "MYR"}
    end)
  end

  defp get_tax_rate(product) do
    Enum.reduce(product.taxes, Decimal.new(0), fn(tax, acc) -> Decimal.add(tax.tax_rate, acc) end)
  end

  defp round_tax_amount(tax_amount) do
    {_, amount, _, _} = Money.to_integer_exp(tax_amount)
    amount = amount / 100
    rounded_amount = Float.ceil(amount * 20) / 20
    Money.new(:MYR, rounded_amount)
  end
end
