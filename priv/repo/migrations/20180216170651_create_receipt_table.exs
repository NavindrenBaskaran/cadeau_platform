defmodule CadeauPlatform.Repo.Migrations.CreateReceiptTable do
  use Ecto.Migration

  def change do
    create table(:receipts) do
      add :order_id, references(:orders)
      add :total_amount, :integer
      add :total_sales_tax, :integer
      timestamps()
    end
  end
end
