defmodule CadeauPlatform.Repo.Migrations.ChangeColumnTypeOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      remove :chargeable_amount
      add :chargeable_amount, :money_with_currency
    end
  end
end
