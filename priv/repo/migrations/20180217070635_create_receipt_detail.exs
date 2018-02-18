defmodule CadeauPlatform.Repo.Migrations.CreateReceiptDetail do
  use Ecto.Migration

  def change do
    create table(:receipt_details) do
      add :receipt_id, references(:receipts)
      add :purchase_data, {:array, :map}, default: []
      timestamps()
    end
  end
end
