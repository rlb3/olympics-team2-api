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

  def distinct_sport do
    from m in API.Medal,
      distinct: m.sport,
      select: m.sport
  end
end
