defmodule CadeauPlatform.Repo.Migrations.AddImageLinkToProduct do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :image_link, :text
    end
  end
end
