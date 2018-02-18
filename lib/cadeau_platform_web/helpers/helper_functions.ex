defmodule CadeauPlatform.Helpers.HelperFunctions do
  def string_to_atom(params) do
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}
  end
end
