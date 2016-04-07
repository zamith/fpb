defmodule Fpb.Club do
  use Fpb.Web, :model

  schema "clubs" do
    field :name, :string
    field :website_id, :integer
    field :logo_url, :string
    has_many :teams, Fpb.Team

    timestamps
  end

  @required_fields ~w(name website_id)
  @optional_fields ~w(logo_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
