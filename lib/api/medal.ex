defmodule API.Medal do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias API.Medal


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "medals" do
    field :bronze, :integer
    field :bronze_country, :string
    field :bronze_winner, :string
    field :event, :string
    field :gold, :integer
    field :gold_country, :string
    field :gold_winner, :string
    field :silver, :integer
    field :silver_country, :string
    field :silver_winner, :string
    field :sport, :string

    timestamps()
  end

  @doc false
  def changeset(%Medal{} = medal, attrs) do
    medal
    |> cast(attrs, [:sport, :event, :gold, :silver, :bronze, :gold_country, :gold_winner, :silver_country, :silver_winner, :bronze_country, :bronze_winner])
    |> validate_required([:sport, :event, :gold, :silver, :bronze, :gold_country, :gold_winner, :silver_country, :silver_winner, :bronze_country, :bronze_winner])
  end

  def distinct_countries do
    query = from m in Medal,
      select: [m.gold_country, m.silver_country, m.bronze_country]

    query
    |> API.Repo.all
    |> List.flatten
    |> Enum.uniq
  end

  def total_medals(for: country) do
    [gold_medals(for: country), silver_medals(for: country), bronze_medals(for: country)]
    |> Enum.sum
  end

  def gold_medals(for: country) do
    query = from m in Medal,
      where: m.gold_country == ^country,
      select: m.gold

    query |> API.Repo.all |> List.flatten |> Enum.sum
  end

  def silver_medals(for: country) do
    query = from m in Medal,
      where: m.silver_country == ^country,
      select: m.silver

    query |> API.Repo.all |> List.flatten |> Enum.sum
  end

  def bronze_medals(for: country) do
    query = from m in Medal,
      where: m.bronze_country == ^country,
      select: m.bronze

    query |> API.Repo.all |> List.flatten |> Enum.sum
  end

  def metal_object(for: country) do
    %{
      country: country,
      total: total_medals(for: country),
      total_gold: gold_medals(for: country),
      total_silver: silver_medals(for: country),
      total_bronze: bronze_medals(for: country)
    }
  end
end
