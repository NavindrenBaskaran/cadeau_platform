defmodule CadeauPlatform.Shopping.OrderLine do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Shopping.{OrderLine, Order, CartProduct}


  schema "order_lines" do
    belongs_to :order, Order
    belongs_to :product_line, CartProduct
    timestamps()
  end

  @doc false
  def changeset(%OrderLine{} = order_line, attrs) do
    order_line
    |> cast(attrs, [:order_id, :product_line_id])
    |> validate_required([:order_id, :product_line_id])
  end
end
