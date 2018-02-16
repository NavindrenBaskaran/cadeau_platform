defmodule CadeauPlatform.Repo.Migrations.CreateCartsProducts do
  use Ecto.Migration

  def change do
    create table(:carts_products) do
      add :cart_id, references(:carts)
      add :product_id, references(:products)
      timestamps()
    end

  end
end
