defmodule Mix.Tasks.Scraper.Teams do
  use Mix.Task
  use Fpb.Scraper.Task
  alias Fpb.Scraper
  alias Fpb.Repo
  alias Fpb.Team
  alias Fpb.Club

  def run(_args) do
    # Repo.start_link
    Application.ensure_all_started(:tzdata)
    with_hound_session fn ->
      # 1..100 |> Enum.each(&add_club/1)
      add_club(2404)
    end
  end

  def add_club(club_id) do
    Scraper.Club.scrape(club_id)

    changeset = club_with_name(Scraper.Club.name)
    |> Club.changeset(%{
      website_id: club_id,
      logo_url: Scraper.Club.logo
    })

    if Scraper.Club.active? && changeset.valid? do
      club = Repo.insert_or_update!(changeset)
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
    changeset = team_with_attributes(%{name: Scraper.Team.name, club_id: club.id, level: Scraper.Team.level})
    |> Team.changeset(%{ website_id: team_id })

    if Scraper.Team.active? && changeset.valid? do
      Repo.insert_or_update!(changeset)
      |> Mix.Tasks.Scraper.Games.add_games
    end
  end

  defp team_with_attributes(attributes) do
    case Repo.get_by(Team, attributes) do
      nil -> %Team{} |> Map.merge(attributes)
      team -> team
    end
  end
end
