defmodule CadeauPlatform.Checkout.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Checkout.{Order, Receipt}
  alias CadeauPlatform.Account.User
  alias CadeauPlatform.Inventory.Product
  alias CadeauPlatform.Shopping.CartProduct

  schema "orders" do
    belongs_to :user, User
    has_many :product_lines, CartProduct
    has_one  :receipt, Receipt
    field :chargeable_amount, Money.Ecto.Composite.Type

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:user_id, :chargeable_amount])
    |> validate_required([:user_id])
  end
end
