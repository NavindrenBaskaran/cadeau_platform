defmodule CadeauPlatform.Repo.Migrations.AddCategoriesToProduct do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :category_id, references(:categories, on_delete: :nothing)
    end
  end
end
