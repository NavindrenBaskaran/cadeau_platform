defmodule CadeauPlatform.Repo.Migrations.AddStatusToCartProduct do
  use Ecto.Migration

  def change do
    alter table(:carts_products) do
      add :status, :integer
    end
  end
end
