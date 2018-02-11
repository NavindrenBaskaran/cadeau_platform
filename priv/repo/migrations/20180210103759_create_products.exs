defmodule CadeauPlatform.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price_cents, :integer
      add :description, :text
      add :imported, :boolean, default: false
      timestamps()
    end

  end
end
