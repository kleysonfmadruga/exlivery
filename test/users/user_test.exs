defmodule Exlivery.Users.UserTest do
  @moduledoc false

  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns a user" do
      response = User.build("12345678900", "Jose", "jose@gmail.com", 20, "Rua dos bobos")

      expected_response = {:ok, build(:user)}

      assert expected_response == response
    end

    test "when the age is lower than 18 years, returns an error" do
      response = User.build("12345678900", "Jose", "jose@gmail.com", 17, "Rua dos bobos")

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end

    test "when the CPF isn't a bitstring, returns an error" do
      response = User.build(12_345_678_900, "Jose", "jose@gmail.com", 20, "Rua dos bobos")

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
