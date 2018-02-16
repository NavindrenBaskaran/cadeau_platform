defmodule CadeauPlatform.Shopping.CartProduct do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Shopping.CartProduct
  alias CadeauPlatform.Shopping.{CartProduct, Cart}
  alias CadeauPlatform.Inventory.Product


  schema "carts_products" do
    field :quantity, :integer, default: 1
    belongs_to :cart, Cart
    belongs_to :product, Product
    timestamps()
  end

  @doc false
  def changeset(%CartProduct{} = cart_product, attrs) do
    cart_product
    |> cast(attrs, [:cart_id, :product_id, :quantity])
    |> validate_required([:cart_id, :product_id])
  end
end
