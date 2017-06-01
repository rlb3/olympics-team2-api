defmodule API.Repo.Migrations.CreateAPI.TopNews do
  use Ecto.Migration

  def change do
    create table(:top_news, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :date
      add :title, :string
      add :body, :text
      add :photo_url, :string

      timestamps()
    end

  end
end
