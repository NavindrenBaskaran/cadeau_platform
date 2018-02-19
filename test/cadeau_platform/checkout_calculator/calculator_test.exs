defmodule CadeauPlatform.CalculatorTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.CheckoutCalculator.Calculator
  alias CadeauPlatform.Checkout

  describe "total_order_amount" do
    test "case 1, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)

      product1 = insert(:product, name: "book", price: Money.new(12.49, :MYR))
      product2 = insert(:product, name: "music cd", price: Money.new(14.99, :MYR))
      product3 = insert(:product, name: "chocolate bar", price: Money.new(0.85, :MYR))

      # has sales tax only
      product2_tax = insert(:product_tax, product: product2, tax: sales_tax)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))
      cart_product3 = insert(:cart_product, cart: cart, product: Repo.preload(product3, :taxes))

      assert Money.to_string!(Calculator.total_order_amount([cart_product1, cart_product2, cart_product3])) == Money.to_string!(Money.new(29.83, :MYR))
    end

    test "case 2, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)
      import_duty = insert(:tax, name: "Import Duty", tax_rate: 0.05)


      product1 = insert(:product, name: "imported box of chocolates", price: Money.new(10.00, :MYR))
      product2 = insert(:product, name: "imported bottle of perfume", price: Money.new(47.50, :MYR))

      # tax for product 1
      insert(:product_tax, product: product1, tax: import_duty)

      # tax for product2
      insert(:product_tax, product: product2, tax: sales_tax)
      insert(:product_tax, product: product2, tax: import_duty)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))

      assert Money.to_string!(Calculator.total_order_amount([cart_product1, cart_product2])) == Money.to_string!(Money.new(65.15, :MYR))
    end

    test "case 3, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)
      import_duty = insert(:tax, name: "Import Duty", tax_rate: 0.05)

      product1 = insert(:product, name: "imported bottle of perfume", price: Money.new(27.99, :MYR))
      product2 = insert(:product, name: "bottle of perfume", price: Money.new(18.99, :MYR))
      product3 = insert(:product, name: "packet of headache pills", price: Money.new(9.75, :MYR))
      product4 = insert(:product, name: "imported box of chocolates", price: Money.new(11.25, :MYR))

      # tax for product1
      insert(:product_tax, product: product1, tax: sales_tax)
      insert(:product_tax, product: product1, tax: import_duty)

      # tax for product 2
      insert(:product_tax, product: product2, tax: sales_tax)

      # tax for product 4
      insert(:product_tax, product: product4, tax: import_duty)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))
      cart_product3 = insert(:cart_product, cart: cart, product: Repo.preload(product3, :taxes))
      cart_product4 = insert(:cart_product, cart: cart, product: Repo.preload(product4, :taxes))

      assert Money.to_string!(Calculator.total_order_amount([cart_product1, cart_product2, cart_product3, cart_product4])) == Money.to_string!(Money.new(74.68, :MYR))
    end

  end

  describe "total_sales_tax_amount" do
    test "case 1, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)

      product1 = insert(:product, name: "book", price: Money.new(12.49, :MYR))
      product2 = insert(:product, name: "music cd", price: Money.new(14.99, :MYR))
      product3 = insert(:product, name: "chocolate bar", price: Money.new(0.85, :MYR))

      # has sales tax only
      product2_tax = insert(:product_tax, product: product2, tax: sales_tax)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))
      cart_product3 = insert(:cart_product, cart: cart, product: Repo.preload(product3, :taxes))

      assert Money.to_string!(Calculator.total_sales_tax_amount([cart_product1, cart_product2, cart_product3])) == Money.to_string!(Money.new(1.50, :MYR))
    end

    test "case 2, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)
      import_duty = insert(:tax, name: "Import Duty", tax_rate: 0.05)


      product1 = insert(:product, name: "imported box of chocolates", price: Money.new(10.00, :MYR))
      product2 = insert(:product, name: "imported bottle of perfume", price: Money.new(47.50, :MYR))

      # tax for product 1
      insert(:product_tax, product: product1, tax: import_duty)

      # tax for product2
      insert(:product_tax, product: product2, tax: sales_tax)
      insert(:product_tax, product: product2, tax: import_duty)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))

      assert Money.to_string!(Calculator.total_sales_tax_amount([cart_product1, cart_product2])) == Money.to_string!(Money.new(7.65, :MYR))
    end

    test "case 3, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)
      import_duty = insert(:tax, name: "Import Duty", tax_rate: 0.05)

      product1 = insert(:product, name: "imported bottle of perfume", price: Money.new(27.99, :MYR))
      product2 = insert(:product, name: "bottle of perfume", price: Money.new(18.99, :MYR))
      product3 = insert(:product, name: "packet of headache pills", price: Money.new(9.75, :MYR))
      product4 = insert(:product, name: "imported box of chocolates", price: Money.new(11.25, :MYR))

      # tax for product1
      insert(:product_tax, product: product1, tax: sales_tax)
      insert(:product_tax, product: product1, tax: import_duty)

      # tax for product 2
      insert(:product_tax, product: product2, tax: sales_tax)

      # tax for product 4
      insert(:product_tax, product: product4, tax: import_duty)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))
      cart_product3 = insert(:cart_product, cart: cart, product: Repo.preload(product3, :taxes))
      cart_product4 = insert(:cart_product, cart: cart, product: Repo.preload(product4, :taxes))

      assert Money.to_string!(Calculator.total_sales_tax_amount([cart_product1, cart_product2, cart_product3, cart_product4])) == Money.to_string!(Money.new(6.70, :MYR))
    end
  end

  describe "payable_per_product" do
    test "case 1, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)

      product1 = insert(:product, name: "book", price: Money.new(12.49, :MYR))
      product2 = insert(:product, name: "music cd", price: Money.new(14.99, :MYR))
      product3 = insert(:product, name: "chocolate bar", price: Money.new(0.85, :MYR))

      # has sales tax only
      product2_tax = insert(:product_tax, product: product2, tax: sales_tax)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))
      cart_product3 = insert(:cart_product, cart: cart, product: Repo.preload(product3, :taxes))

      assert Calculator.payable_per_product([cart_product1, cart_product2, cart_product3]) ==  [%{name: "book", quantity: 1, product_price: Decimal.new(12.49), total_tax_rate: Decimal.new(0), total: Decimal.new(12.49), sales_tax: Decimal.new(0.0), total_with_sales_tax: Decimal.new(12.49), currency: "MYR"},
                                                                                                %{name: "music cd", quantity: 1, product_price: Decimal.new(14.99), total_tax_rate: Decimal.new(0.1), total: Decimal.new(14.99), sales_tax: Decimal.new(1.5), total_with_sales_tax: Decimal.new(16.49), currency: "MYR"},
                                                                                                %{name: "chocolate bar", quantity: 1, product_price: Decimal.new(0.85), total_tax_rate: Decimal.new(0), total: Decimal.new(0.85), sales_tax: Decimal.new(0.0), total_with_sales_tax: Decimal.new(0.85), currency: "MYR"}]
    end

    test "case 2, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)
      import_duty = insert(:tax, name: "Import Duty", tax_rate: 0.05)


      product1 = insert(:product, name: "imported box of chocolates", price: Money.new(10.00, :MYR))
      product2 = insert(:product, name: "imported bottle of perfume", price: Money.new(47.50, :MYR))

      # tax for product 1
      insert(:product_tax, product: product1, tax: import_duty)

      # tax for product2
      insert(:product_tax, product: product2, tax: sales_tax)
      insert(:product_tax, product: product2, tax: import_duty)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))

      assert Calculator.payable_per_product([cart_product1, cart_product2]) ==  [%{name: "imported box of chocolates", quantity: 1, product_price: Decimal.new(10.0), total_tax_rate: Decimal.new(0.05), total: Decimal.new(10.0), sales_tax: Decimal.new(0.5), total_with_sales_tax: Decimal.new(10.50), currency: "MYR"},
                                                                                 %{name: "imported bottle of perfume", quantity: 1, product_price: Decimal.new(47.50), total_tax_rate: Decimal.new(0.15), total: Decimal.new(47.50), sales_tax: Decimal.new(7.15), total_with_sales_tax: Decimal.new(54.65), currency: "MYR"}]
    end

    test "case 3, returns correct computation" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      sales_tax = insert(:tax, name: "Sales tax", tax_rate: 0.1)
      import_duty = insert(:tax, name: "Import Duty", tax_rate: 0.05)

      product1 = insert(:product, name: "imported bottle of perfume", price: Money.new(27.99, :MYR))
      product2 = insert(:product, name: "bottle of perfume", price: Money.new(18.99, :MYR))
      product3 = insert(:product, name: "packet of headache pills", price: Money.new(9.75, :MYR))
      product4 = insert(:product, name: "imported box of chocolates", price: Money.new(11.25, :MYR))

      # tax for product1
      insert(:product_tax, product: product1, tax: sales_tax)
      insert(:product_tax, product: product1, tax: import_duty)

      # tax for product 2
      insert(:product_tax, product: product2, tax: sales_tax)

      # tax for product 4
      insert(:product_tax, product: product4, tax: import_duty)

      cart_product1 = insert(:cart_product, cart: cart, product: Repo.preload(product1, :taxes))
      cart_product2 = insert(:cart_product, cart: cart, product: Repo.preload(product2, :taxes))
      cart_product3 = insert(:cart_product, cart: cart, product: Repo.preload(product3, :taxes))
      cart_product4 = insert(:cart_product, cart: cart, product: Repo.preload(product4, :taxes))

      assert Calculator.payable_per_product([cart_product1, cart_product2, cart_product3, cart_product4]) == [%{name: "imported bottle of perfume", quantity: 1, product_price: Decimal.new(27.99), total_tax_rate: Decimal.new(0.15), total: Decimal.new(27.99), sales_tax: Decimal.new(4.20), total_with_sales_tax: Decimal.new(32.19), currency: "MYR"},
                                                                                                              %{name: "bottle of perfume", quantity: 1, product_price: Decimal.new(18.99), total_tax_rate: Decimal.new(0.1), total: Decimal.new(18.99), sales_tax: Decimal.new(1.9), total_with_sales_tax: Decimal.new(20.89), currency: "MYR"},
                                                                                                              %{name: "packet of headache pills", quantity: 1, product_price: Decimal.new(9.75), total_tax_rate: Decimal.new(0), total: Decimal.new(9.75), sales_tax: Decimal.new(0.0), total_with_sales_tax: Decimal.new(9.75), currency: "MYR"},
                                                                                                              %{name: "imported box of chocolates", quantity: 1, product_price: Decimal.new(11.25), total_tax_rate: Decimal.new(0.05), total: Decimal.new(11.25), sales_tax: Decimal.new(0.60), total_with_sales_tax: Decimal.new(11.85), currency: "MYR"}]
    end
  end
end
