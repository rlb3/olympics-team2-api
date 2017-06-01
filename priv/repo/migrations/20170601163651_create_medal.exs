defmodule API.Repo.Migrations.CreateAPI.Medal do
  use Ecto.Migration

  def change do
    create table(:medals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :country_id, references(:countries, on_delete: :nothing, type: :binary_id)
      add :person_id, references(:people, on_delete: :nothing, type: :binary_id)
      add :event_id, references(:events, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:medals, [:country_id])
    create index(:medals, [:person_id])
    create index(:medals, [:event_id])
  end
end
