defmodule Exlivery.Orders.Order do
  @moduledoc """
  A struct that represents a Exlivery order with user CPF, delivery address, a list of items and the total price
  """
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys
  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {
      :ok,
      %__MODULE__{
        user_cpf: cpf,
        delivery_address: address,
        items: items,
        total_price: calculate_total_price(items)
      }
    }
  end

  defp calculate_total_price(items) do
    items
    |> Enum.reduce(
         Decimal.new("0.00"),
         fn item, acc -> sum_prices(item, acc) end
       )
  end

  defp sum_prices(%Item{unitary_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
