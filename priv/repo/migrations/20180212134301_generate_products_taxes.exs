defmodule CadeauPlatform.Repo.Migrations.GenerateProductsTaxes do
  use Ecto.Migration

  def change do
    create table(:products_taxes) do
      add :product_id, references(:products)
      add :tax_id, references(:taxes)
      timestamps
    end
  end
end
