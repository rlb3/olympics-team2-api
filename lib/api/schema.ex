defmodule API.Schema do
  use Absinthe.Schema
  alias Absinthe.Type.{Field, Object}
  alias API.Repo

  object :top_news do
    field :id, :id
    field :title, :string
    field :body, :string
    field :photo_url, :string
    field :photo_name, :string
  end

  object :medal do
    field :country, :string
    field :total, :integer
    field :total_gold, :integer
    field :total_silver, :integer
    field :total_bronze, :integer
  end


  query do
    field :medals, list_of(:medal) do
      resolve fn _arg, _context ->
        map = API.Medal.distinct_countries
        |> Enum.map(fn country ->
          API.Medal.metal_object(for: country)
        end)
        {:ok, map}
      end
    end

    field :top_news, list_of(:top_news) do
      resolve fn _arg, _context ->
        top_news =
          Repo.all(API.TopNews)
          |> Enum.map(fn news ->
             %{news | photo_name: String.replace_prefix(news.photo_url, "/images/", "")}
             end)

        {:ok, top_news}
      end
    end
  end
end
