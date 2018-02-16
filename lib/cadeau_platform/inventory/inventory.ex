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
end
