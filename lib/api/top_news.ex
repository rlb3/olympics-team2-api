defmodule API.TopNews do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.TopNews

  @moduledoc """
  API.TopNews

  No helper functions
  """

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "top_news" do
    field :title, :string
    field :body, :string
    field :date, :date
    field :photo_url, :string
    field :photo_name, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%TopNews{} = top_news, attrs) do
    top_news
    |> cast(attrs, [:date, :body, :photo, :photo_name])
    |> validate_required([:date, :body, :photo])
  end
end
