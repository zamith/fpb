defmodule Fpb.Repo.Migrations.AddUniqueIndexToClubsAndTeams do
  use Ecto.Migration

  def change do
    create unique_index(:clubs, [:name])
    create unique_index(:teams, [:name, :club_id])
  end
end
