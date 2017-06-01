defmodule API.Schema do
  use Absinthe.Schema
  alias Absinthe.Type.{Field, Object}
  alias API.Repo

  object :top_news do
    field :id, :id
    field :title, :string
    field :body, :string
    field :photo_url, :string
  end

  object :medal do
    field :id, :id
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

    field :top_news, list_of(:top_news) do
      resolve fn _arg, _context ->
        {:ok, Repo.all(API.TopNews)}
      end
    end
  end
end
