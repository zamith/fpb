defmodule Fpb.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :date, :datetime
      add :gym, :string
      add :home_team_id, references(:teams, on_delete: :nothing)
      add :away_team_id, references(:teams, on_delete: :nothing)

      timestamps
    end
    create index(:games, [:home_team_id])
    create index(:games, [:away_team_id])

  end
end
