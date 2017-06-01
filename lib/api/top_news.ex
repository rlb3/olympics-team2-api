defmodule API.TopNews do
  use Ecto.Schema
  import Ecto.Changeset
  alias API.TopNews


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "top_news" do
    field :title, :string
    field :body, :string
    field :date, :date
    field :photo_url, :string

    timestamps()
  end

  @doc false
  def changeset(%TopNews{} = top_news, attrs) do
    top_news
    |> cast(attrs, [:date, :body, :photo])
    |> validate_required([:date, :body, :photo])
  end
end
