defmodule Mix.Tasks.Scraper.Teams do
  use Mix.Task
  use Fpb.Scraper.Task
  alias Fpb.Scraper
  alias Fpb.Repo
  alias Fpb.Team
  alias Fpb.Club

  def run(_args) do
    Repo.start_link
    Application.ensure_all_started(:tzdata)
    with_hound_session fn ->
      1..100 |> Enum.each(&add_club/1)
    end
  end

  defp add_club(club_id) do
    Scraper.Club.scrape(club_id)

    changeset = club_with_name(Scraper.Club.name)
    |> Club.changeset(%{
      website_id: club_id,
      logo_url: Scraper.Club.logo
    })

    if Scraper.Club.active? && changeset.valid? do
      {:ok, club} = Repo.insert_or_update(changeset)
      Scraper.Club.interesting_team_ids |> Enum.map(&(add_team(&1, club)))
    end
  end

  defp club_with_name(name) do
    case Repo.get_by(Club, name: name) do
      nil -> %Club{name: name}
      club -> club
    end
  end

  defp add_team(team_id, club) do
    Scraper.Team.scrape(team_id)
    changeset = team_with_name(Scraper.Team.name)
    |> Team.changeset(%{
      website_id: team_id,
      level: Scraper.Team.level,
      club_id: club.id
    })
    if Scraper.Team.active? && changeset.valid? do
      Repo.insert_or_update(changeset)
    end
  end

  defp team_with_name(name) do
    case Repo.get_by(Team, name: name) do
      nil -> %Team{name: name}
      team -> team
    end
  end
end
