defmodule Fpb.Repo.Migrations.CreateClub do
  use Ecto.Migration

  def change do
    create table(:clubs) do
      add :name, :string
      add :website_id, :integer
      add :logo_url, :string

      timestamps
    end

  end
end
