defmodule Exlivery.Orders.OrderTest do
  @moduledoc false

  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Pizza de frango com catupiry",
          category: :pizza,
          quantity: 1,
          unit_price: Decimal.new("25.99")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert expected_response == response
    end

    test "when there is a empty item list, returns an error" do
      user = build(:user)

      response = Order.build(user, [])

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
