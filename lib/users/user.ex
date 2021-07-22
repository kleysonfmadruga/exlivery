defmodule Exlivery.Users.User do
  @moduledoc """
  A struct that represents a user with CPF, name, email and age
  """
  @keys [:cpf, :name, :email, :age, :address]

  @enforce_keys @keys
  defstruct @keys

  def build(cpf, name, email, age, address) when age >= 18 and is_bitstring(cpf) do
    {
      :ok,
      %__MODULE__{
        cpf: cpf,
        name: name,
        email: email,
        age: age,
        address: address
      }
    }
  end

  def build(_cpf, _name, _email, _age, _address), do: {:error, "Invalid parameters"}
end
