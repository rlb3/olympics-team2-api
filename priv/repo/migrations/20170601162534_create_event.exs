defmodule API.Repo.Migrations.CreateAPI.Event do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :sport_id, references(:sports, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:events, [:sport_id])
  end
end
