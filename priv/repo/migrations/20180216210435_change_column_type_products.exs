defmodule CadeauPlatform.Repo.Migrations.ChangeColumnTypeProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      remove :price_cents
      add :price, :money_with_currency
    end
  end
end
