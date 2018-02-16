defmodule CadeauPlatform.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users)
      add :chargeable_amount, :integer
      timestamps()
    end
  end
end
