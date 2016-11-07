defmodule Fpb.Repo.Migrations.AddUniqueIndexToClubsAndTeams do
  use Ecto.Migration

  def change do
    create unique_index(:clubs, [:name])
    create unique_index(:teams, [:name, :level, :club_id], name: "team_unique_for_club")
  end
end
