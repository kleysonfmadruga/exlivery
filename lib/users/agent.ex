defmodule Exlivery.Users.Agent do
  @moduledoc false

  use Agent

  alias Exlivery.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user),
    do: Agent.update(__MODULE__, fn current_state -> update_state(current_state, user) end)

  def get(cpf), do: Agent.get(__MODULE__, fn current_state -> get_user(current_state, cpf) end)

  defp update_state(current_state, %User{cpf: cpf} = user), do: Map.put(current_state, cpf, user)

  defp get_user(current_state, cpf) do
    case Map.get(current_state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
