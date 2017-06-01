defmodule API.Sport do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.Sport


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sports" do
    field :name, :string
    has_many :events, API.Event

    timestamps()
  end

  @doc false
  def changeset(%Sport{} = sport, attrs) do
    sport
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
