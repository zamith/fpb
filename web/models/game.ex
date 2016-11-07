defmodule Fpb.Game do
  use Fpb.Web, :model

  schema "games" do
    field :date, Timex.Ecto.DateTime
    field :gym, :string
    belongs_to :home_team, Fpb.Team
    belongs_to :away_team, Fpb.Team

    timestamps
  end

  @required_fields ~w(date gym)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:home_team)
    |> assoc_constraint(:away_team)
  end
end
