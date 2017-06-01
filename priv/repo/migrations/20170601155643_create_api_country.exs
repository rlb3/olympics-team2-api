defmodule API.Repo.Migrations.CreateAPI.API.Country do
  use Ecto.Migration

  def change do
    create table(:countries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :abr, :string

      timestamps()
    end

  end
end
