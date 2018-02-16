defmodule CadeauPlatform.Shopping do
  @moduledoc """
  The Shopping context.
  """

  import Ecto.Query, warn: false
  alias CadeauPlatform.Repo

  alias CadeauPlatform.Shopping.Cart
  alias CadeauPlatform.Shopping.CartProduct
  alias CadeauPlatform.Inventory.Product
  alias CadeauPlatform.Shopping.Order
  alias CadeauPlatform.Shopping.OrderLine

  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
  end

  def get_cart(id) do
    Cart
    |> Repo.get(id)
  end

  def get_products_in_cart(id) do
    query = from cp in CartProduct,
            where: cp.cart_id == ^id

    query
    |> Repo.all
    |> Repo.preload(:product)
  end

  def add_product_to_cart(attrs) do
    case product_exist_in_cart?(Map.get(attrs, :product_id), Map.get(attrs, :cart_id)) do
      [] ->
        %CartProduct{}
        |> CartProduct.changeset(attrs)
        |> Repo.insert()
      [product_line] ->
        update_quantity(product_line, 1)
    end
  end

  def update_product_quantity(shopping_cart_id, product_id, quantity) do

  end

  def remove_product_from_cart(shopping_cart_id, product_id) do

  end

  def product_exist_in_cart?(product_id, cart_id) do
    query = from cp in CartProduct,
            where: cp.cart_id == ^cart_id and cp.product_id == ^product_id
    Repo.all(query)
  end

  def update_quantity(product_line, quantity) do
    quantity = product_line.quantity + quantity
    changeset = CartProduct.changeset(product_line, %{quantity: quantity})
    Repo.update(changeset)
  end
end
