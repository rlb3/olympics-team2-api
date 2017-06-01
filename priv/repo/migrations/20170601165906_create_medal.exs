defmodule API.Repo.Migrations.CreateAPI.Medal do
  use Ecto.Migration

  def change do
    create table(:medals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :sport, :string
      add :event, :string
      add :gold, :integer
      add :silver, :integer
      add :bronze, :integer
      add :gold_country, :string
      add :gold_winner, :string
      add :silver_country, :string
      add :silver_winner, :string
      add :bronze_country, :string
      add :bronze_winner, :string

      timestamps()
    end

  end
end
