defmodule CadeauPlatform.Repo.Migrations.AddQuantitytoCartProduct do
  use Ecto.Migration

  def change do
    alter table(:carts_products) do
      add :quantity, :integer, default: 1
    end
  end
end
