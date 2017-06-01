defmodule API.Schema do
  use Absinthe.Schema
  alias Absinthe.Type.{Field, Object}
  alias API.Repo

  object :medal do
    field :id
    field :sport, :string
    field :event, :string
    field :gold, :integer
    field :silver, :integer
    field :bronze, :integer
    field :bronze_country, :string
    field :bronze_winner, :string
    field :silver_country, :string
    field :silver_winner, :string
    field :bronze_country, :string
    field :bronze_winner, :string
  end

  query do
    field :all, list_of(:medal) do
    resolve fn _arg, _context ->
        {:ok, Repo.all(API.Medal)}
      end
    end
  end
end
