defmodule CadeauPlatform.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name,  :string
      add :password_digest, :string
      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
