defmodule CadeauPlatformWeb.PageView do
  use CadeauPlatformWeb, :view

  def imported_product?(item) do
    case item.imported do
      true
        -> "Foreign Product"
      false
        -> "Local Product"
    end
  end
end
