defmodule Fpb.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :website_id, :integer
      add :level, :string
      add :club_id, references(:clubs)

      timestamps
    end

  end
end
