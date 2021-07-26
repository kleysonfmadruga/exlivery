defmodule Exlivery.Users.Upsert do
  @moduledoc false

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{cpf: cpf, name: name, address: address, email: email, age: age}) do
    cpf
    |> User.build(name, email, age, address)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}), do: UserAgent.save(user)
  defp save_user({:error, _reason} = error), do: error
end
