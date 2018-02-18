import EctoEnum
defenum CartProductStatus, in_cart: 0, checked_out: 1

defmodule CadeauPlatform.Shopping.CartProduct do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Shopping.CartProduct
  alias CadeauPlatform.Shopping.{CartProduct, Cart, Order}
  alias CadeauPlatform.Inventory.Product


  schema "carts_products" do
    field :quantity, :integer, default: 1
    field :status, CartProductStatus, default: 0
    belongs_to :cart, Cart
    belongs_to :product, Product
    belongs_to :order, Order
    timestamps()
  end

  @doc false
  def changeset(%CartProduct{} = cart_product, attrs) do
    cart_product
    |> Ecto.Changeset.cast(attrs, [:cart_id, :product_id, :quantity, :status])
    |> validate_required([:cart_id, :product_id, :status])
  end
end
