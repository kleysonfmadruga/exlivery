defmodule Exlivery.Orders.Agent do
  @moduledoc false

  use Agent

  alias Exlivery.Orders.Order

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, fn current_state -> update_state(current_state, order, uuid) end)

    {:ok, uuid}
  end

  def get(uuid), do: Agent.get(__MODULE__, fn current_state -> get_order(current_state, uuid) end)

  defp get_order(current_state, uuid) do
    case Map.get(current_state, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  defp update_state(current_state, %Order{} = order, uuid),
    do: Map.put(current_state, uuid, order)
end
