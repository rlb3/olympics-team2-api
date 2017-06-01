defmodule API.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.Country


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "countries" do
    field :abr, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Country{} = country, attrs) do
    country
    |> cast(attrs, [:name, :abr])
    |> validate_required([:name, :abr])
  end
end
