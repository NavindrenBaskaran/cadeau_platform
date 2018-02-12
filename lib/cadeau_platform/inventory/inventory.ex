defmodule CadeauPlatform.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias CadeauPlatform.Repo

  alias CadeauPlatform.Inventory.Product
  alias CadeauPlatform.Inventory.Tax

  def list_products do
    Product
    |> preload(:category)
    |> preload(:taxes)
    |> Repo.all
  end

  def get_selected_products(selected_product_ids) do
    Product
    |> where([p], p.id in ^selected_product_ids)
    |> preload(:category)
    |> preload(:taxes)
    |> Repo.all
  end
end
