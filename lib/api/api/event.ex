defmodule API.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.Event


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :name, :string
    belongs_to :sport, API.Sport
    has_many :medals, API.Medal

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
