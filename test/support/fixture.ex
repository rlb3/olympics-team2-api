defmodule API.Test.Helper do
  def fixture(:usa) do
    [%API.Medal{gold: 2, gold_country: "USA"},
     %API.Medal{silver: 3, silver_country: "USA"},
     %API.Medal{bronze: 1, bronze_country: "USA"}
    ]
     |> Enum.each(fn struct ->
      API.Repo.insert! struct
    end)
  end
end
