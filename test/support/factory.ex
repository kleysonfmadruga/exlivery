defmodule Exlivery.Factory do
  @moduledoc false

  use ExMachina

  alias Exlivery.Orders.Item
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

  def item_factory do
    %Item{
      description: "Açaí",
      category: :sobremesa,
      quantity: 1,
      unit_price: Decimal.new("10.99")
    }
  end
end
