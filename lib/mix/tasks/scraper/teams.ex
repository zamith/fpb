defmodule Mix.Tasks.Scrapper.Teams do
  use Mix.Task
  alias Fpb.Scraper
  alias Fpb.Repo
  alias Fpb.Team
  alias Fpb.Club

  def run(_args) do
    Repo.start_link
    Application.ensure_all_started(:tzdata)
    with_hound_session fn ->
      Scraper.Club.scrape(2404)
      IO.inspect Scraper.Club.active?
      # 1..100 |> Enum.each(&(add_club(&1)))
    end
  end

  defp add_club(club_id) do
    Scraper.Club.scrape(club_id)
    changeset = Club.changeset(%Club{}, %{
      name: Scraper.Club.name,
      website_id: club_id,
      logo_url: Scraper.Club.logo
    })
    if Scrapper.Club.active? && changeset.valid? do
      Repo.insert(changeset)
      interesting_teams |> Enum.each(&(add_team(&1)))
    end
  end

  defp add_team(team_id) do
    Scraper.Team.scrape(team_id)
    changeset = Team.changeset(%Team{}, %{
      name: Scraper.Team.name,
      website_id: team_id,
      logo_url: Scraper.Team.logo,
      level: Scraper.Team.level
    })
    if changeset.valid? do
      Repo.insert(changeset)
    end
  end

  defp interesting_teams do
    Scraper.Club.interesting_team_ids
  end

  defp with_hound_session(block) do
    Application.ensure_all_started(:hound)
    Hound.start_session
    block.()
    Hound.end_session
  end
end
