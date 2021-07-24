defmodule Exlivery.Factory do
  @moduledoc false
  
  use ExMachina

  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Rua dos bobos",
      age: 20,
      cpf: "12345678900",
      email: "jose@gmail.com",
      name: "Jose"
    }
  end
end
