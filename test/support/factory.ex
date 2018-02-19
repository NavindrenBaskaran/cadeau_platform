defmodule CadeauPlatform.Factory do

  use ExMachina.Ecto, repo: CadeauPlatform.Repo

  def user_factory do
    %CadeauPlatform.Accounts.User{
      name: "Jane Smith",
      email: "smith@gmail.com",
      password_digest: Comeonin.Bcrypt.hashpwsalt("test")
    }
  end

  def cart_factory do
    %CadeauPlatform.Shopping.Cart{
      user: nil
    }
  end

  def order_factory do
    %CadeauPlatform.Checkout.Order{
      user: nil,
      chargeable_amount: Money.new(10, :MYR)
    }
  end

  def category_factory do
    %CadeauPlatform.Inventory.Category{
      name: "Book",
      type: :book
    }
  end

  def product_factory do
    %CadeauPlatform.Inventory.Product{
      name: "Test Book",
      price: Money.new(10, :MYR),
      description: "Test Book",
      image_link: "http://www.fakejpeg.com",
      category: insert(:category),
    }
  end

  def tax_factory do
    %CadeauPlatform.Inventory.Tax{
      name: "Test",
      tax_rate: 0.0
    }
  end

  def product_tax_factory do
    %CadeauPlatform.Inventory.ProductTax{
      product: nil,
      tax: nil
    }
  end

  def cart_product_factory do
    %CadeauPlatform.Shopping.CartProduct{
      cart: insert(:cart),
      product: insert(:product),
      quantity: 1,
      status: :in_cart,
      order: nil,
    }
  end
end
