defmodule API.MedalTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(API.Repo)
    API.Test.Helper.fixture(:usa)

    gold = API.Medal.gold_medals(for: "USA")
    silver = API.Medal.silver_medals(for: "USA")
    bronze = API.Medal.bronze_medals(for: "USA")
    total = API.Medal.total_medals(for: "USA")
    object = API.Medal.metal_object(for: "USA")

    {:ok, total: total, gold: gold, silver: silver, bronze: bronze, object: object}
  end

  test "Gold medal count", %{gold: gold} do
    assert gold == 2
  end

  test "Silver medal count", %{silver: silver} do
    assert silver == 3
  end

  test "Bronze medal count", %{bronze: bronze} do
    assert bronze == 1
  end

  test "Total medal count", %{total: total, gold: gold, silver: silver, bronze: bronze} do
    assert total == gold + silver + bronze
  end

  test "Object map", %{object: object, total: total, gold: gold, silver: silver, bronze: bronze} do
    assert object == %{
      country: "USA",
      total: total,
      total_gold: gold,
      total_silver: silver,
      total_bronze: bronze
    }
  end
end
