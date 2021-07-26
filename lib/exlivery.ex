defmodule Exlivery do
  @moduledoc false

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Upsert, as: OrderUpsert
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.Upsert, as: UserUpsert

  def start_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  defdelegate upsert_user(params), to: UserUpsert, as: :call
  defdelegate upsert_order(params), to: OrderUpsert, as: :call
end
