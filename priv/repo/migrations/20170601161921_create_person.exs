defmodule API.Repo.Migrations.CreateAPI.Person do
  use Ecto.Migration

  def change do
    create table(:people, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :country_id, references(:countries, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:people, [:country_id])
  end
end
