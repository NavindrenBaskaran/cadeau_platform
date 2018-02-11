defmodule CadeauPlatform.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :type, :integer
      timestamps()
    end

  end
end
