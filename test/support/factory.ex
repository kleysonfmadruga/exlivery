defmodule Exlivery.Factory do
  @moduledoc false

  use ExMachina

  alias Exlivery.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      delivery_address: "Rua dos bobos",
      items: [
        build(:item),
        build(:item,
          description: "Pizza de frango com catupiry",
          category: :pizza,
          quantity: 1,
          unit_price: Decimal.new("25.99")
        )
      ],
      total_price: Decimal.new("36.98"),
      user_cpf: "12345678900"
    }
  end
end
