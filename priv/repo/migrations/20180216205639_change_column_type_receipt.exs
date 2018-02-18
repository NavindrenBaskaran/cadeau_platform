defmodule CadeauPlatform.Repo.Migrations.ChangeColumnTypeReceipt do
  use Ecto.Migration

  def change do
    alter table(:receipts) do
      remove :total_amount
      remove :total_sales_tax

      add :total_amount, :money_with_currency
      add :total_sales_tax, :money_with_currency
    end
  end
end
