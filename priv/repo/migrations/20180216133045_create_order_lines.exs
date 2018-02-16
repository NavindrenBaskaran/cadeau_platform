defmodule CadeauPlatform.Repo.Migrations.CreateOrderLines do
  use Ecto.Migration

  def change do
    create table(:order_lines) do
      add :order_id, references(:orders)
      add :product_line_id, references(:carts_products)
      timestamps()
    end
  end
end
