defmodule CadeauPlatformWeb.PageView do
  use CadeauPlatformWeb, :view

  def imported_product?(item) do
    case item.imported do
      true
        -> "* Imported Product"
      false
        -> ""
    end
  end
end
