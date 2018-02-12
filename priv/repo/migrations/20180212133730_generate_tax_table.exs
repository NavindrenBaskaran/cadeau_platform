defmodule CadeauPlatform.Repo.Migrations.GenerateTaxTable do
  use Ecto.Migration

  def change do
    create table(:taxes) do
      add :name, :string
      add :tax_rate, :decimal, default: 0.0
      timestamps()
    end
  end
end
