defmodule API.Schema do
  use Absinthe.Schema
  alias Absinthe.Type.{Field, Object}
  alias API.Repo

  @moduledoc """
  GraphQL schema

  # Queries

  ## topNews
  - id: UUID
  - title: String
  - body: String
  - photo_url: URL to image file
  - photo_name: Image file name minus /images/

  ## medals
  - country: Country name
  - total: Total number of medals for a country
  - total_gold: Total number of gold medals for a country
  - total_silver: Total number of silver medals for a country
  - total_bronze: Total number ot silver medals for a country
  """

  object :top_news do
    field :id, :id
    field :title, :string, description: "News title"
    field :body, :string, description: "News body"
    field :photo_url, :string, description: "Photo URL"
    field :photo_name, :string, description: "Photo Name"
  end

  object :medal do
    field :country, :string, description: "Country name"
    field :total, :integer, description: "Total metals for the country"
    field :total_gold, :integer, description: "Total gold metals for the country"
    field :total_silver, :integer, description: "Total silver metals for the country"
    field :total_bronze, :integer, description: "Total bronze metals for the country"
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
