defmodule Exlivery.Orders.ItemTest do
  @moduledoc false

  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params are valid, returns an item" do
      response = Item.build("Açaí", :sobremesa, "10.99", 1)

      expected_response = {:ok, build(:item)}

      assert expected_response == response
    end

    test "when there is an invalid category, returns an error" do
      response = Item.build("Açaí", :foo, "10.99", 1)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end

    test "when there is an invalid price, returns an error" do
      response = Item.build("Açaí", :sobremesa, "foo", 1)

      expected_response = {:error, "Invalid price"}

      assert expected_response == response
    end

    test "when there is an invalid quantity, returns an error" do
      response = Item.build("Açaí", :sobremesa, "10.99", 0)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
