defmodule API.Medal do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.Medal


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "medals" do
    field :type, :string
    belongs_to :country, API.Country
    belongs_to :person, API.Person
    belongs_to :event, API.Event

    timestamps()
  end

  @doc false
  def changeset(%Medal{} = medal, attrs) do
    medal
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
