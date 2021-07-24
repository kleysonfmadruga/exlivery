defmodule Exlivery.Orders.Item do
  @moduledoc """
  A struct that represents a Exlivery order item with category, description, unit price and quantity
  """
  @categories [:pizza, :hamburguer, :carne, :prato_feito, :japonesa, :sobremesa]
  @keys [:description, :category, :unit_price, :quantity]

  @enforce_keys @keys
  defstruct @keys

  def build(description, category, unit_price, quantity)
      when quantity > 0 and category in @categories do
    unit_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  def build(_description, _category, _unit_price, _quantity), do: {:error, "Invalid parameters"}

  defp build_item({:ok, unit_price}, description, category, quantity) do
    {
      :ok,
      %__MODULE__{
        description: description,
        category: category,
        unity_price: unit_price,
        quantity: quantity
      }
    }
  end

  defp build_item(:error, description, category, quantity), do: {:error, "Invalid price"}
end