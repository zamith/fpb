defmodule Fpb.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :website_id, :integer
      add :level, :string

      timestamps
    end

  end
end
