defmodule API.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.Person


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "people" do
    field :first_name, :string
    field :last_name, :string
    belongs_to :country, API.Country
    has_many :medals, API.Medal

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
