defmodule Fpb.Team do
  use Fpb.Web, :model

  schema "teams" do
    field :name, :string
    field :website_id, :integer
    field :level, :string
    belongs_to :club, Fpb.Club

    timestamps
  end

  @required_fields ~w(name website_id)
  @optional_fields ~w(level)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name, name: :teams_name_club_id_index)
  end
end
