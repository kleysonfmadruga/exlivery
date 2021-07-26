defmodule Exlivery.Orders.Upsert do
  @moduledoc false

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.Agent, as: UserAgent

  def call(%{user_cpf: cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(cpf),
         {:ok, items} <- build_items(items),
         {:ok, order} <- Order.build(user, items) do
      OrderAgent.save(order)
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(fn item -> build_item(item)end)
    |> handle_build()
  end

  defp build_item(%{
         description: description,
         category: category,
         unit_price: unit_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unit_price, quantity) do
      {:ok, item} -> item
      {:error, _reason} = error -> error
    end
  end

  defp handle_build(item_list) do
    if Enum.all?(item_list, &is_struct/1), do: {:ok, item_list}, else: {:error, "Invalid items"}
  end
end
