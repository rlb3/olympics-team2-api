defmodule API.Schema do
  use Absinthe.Schema
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
  - date: Date of story

  ## medals
  - country: Country name
  - total: Total number of medals for a country
  - total_gold: Total number of gold medals for a country
  - total_silver: Total number of silver medals for a country
  - total_bronze: Total number ot silver medals for a country
  """

  @desc """
  - id: UUID
  - title: String
  - body: String
  - photo_url: URL to image file
  - photo_name: Image file name minus /images/
  - date: Date of story
  """
  object :top_news do
    field :id, :id
    field :title, :string, description: "News title"
    field :body, :string, description: "News body"
    field :photo_url, :string, description: "Photo URL"
    field :photo_name, :string, description: "Photo Name"
    field :date, :string, description: "Date"
  end

  @desc """
  - country: Country name
  - total: Total number of medals for a country
  - total_gold: Total number of gold medals for a country
  - total_silver: Total number of silver medals for a country
  - total_bronze: Total number ot silver medals for a country
  """
  object :medal do
    field :country, :string, description: "Country name"
    field :total, :integer, description: "Total metals for the country"
    field :total_gold, :integer, description: "Total gold metals for the country"
    field :total_silver, :integer, description: "Total silver metals for the country"
    field :total_bronze, :integer, description: "Total bronze metals for the country"
  end

  query do
    field :medals, list_of(:medal), description: "Metals and the tallies for total metals won, number of gold, silver and bronze metals" do
      resolve fn _arg, _context ->
        case API.Cache.get_medals do
          nil ->
            map = API.Medal.distinct_countries
            |> Enum.map(fn country ->
              API.Medal.metal_object(for: country)
            end)
            API.Cache.set_medals(map)
            {:ok, map}
          map ->
            {:ok, map}
        end
      end
    end

    field :top_news, list_of(:top_news), description: "Top news feed" do
      resolve fn _arg, _context ->
        case API.Cache.get_news do
          nil ->
            top_news =
              API.TopNews
              |> Repo.all
              |> Enum.map(fn news ->
              %{news | photo_name: String.replace_prefix(news.photo_url, "/images/", ""), date: Timex.format!(news.date, "%m/%d/%Y", :strftime) }
            end)

            {:ok, top_news}
          top_news ->
            {:ok, top_news}
        end
      end
    end
  end
end
