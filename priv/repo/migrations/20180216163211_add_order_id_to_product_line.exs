defmodule CadeauPlatform.Repo.Migrations.AddOrderIDToProductLine do
  use Ecto.Migration

  def change do
    alter table(:carts_products) do
      add :order_id, references(:orders)
    end
  end
end
