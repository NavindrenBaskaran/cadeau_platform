defmodule CadeauPlatform.Repo.Migrations.CreateUniqueIndexForUserIDCartsTable do
  use Ecto.Migration

  def change do
    create unique_index(:carts, [:user_id])
  end
end
