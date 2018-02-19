defmodule CadeauPlatform.Shopping do
  @moduledoc """
  The Shopping context.
  """

  import Ecto.Query, warn: false
  alias CadeauPlatform.Repo

  alias CadeauPlatform.Shopping.{Cart, CartProduct}

  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
  end

  def get_cart_by_user_id(user_id) do
    Cart
    |> Repo.get_by(user_id: user_id)
  end

  def get_cart(id) do
    Cart
    |> Repo.get(id)
  end

  def get_products_in_cart(user_id, id) do
    query = from cp in CartProduct,
            join: c in Cart, on: c.id == cp.cart_id,
            where: c.user_id == ^user_id and
                   cp.cart_id == ^id and
                   cp.status == ^:in_cart

    query
    |> Repo.all
    |> Repo.preload(product: :taxes)
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

  defp update_quantity(product_line, quantity) do
    quantity = product_line.quantity + quantity
    changeset = CartProduct.changeset(product_line, %{quantity: quantity})
    Repo.update(changeset)
  end

  defp product_exist_in_cart?(product_id, cart_id) do
    query = from cp in CartProduct,
            where: cp.cart_id == ^cart_id and
                   cp.status == ^:in_cart and
                   cp.product_id == ^product_id
    Repo.all(query)
  end
end
