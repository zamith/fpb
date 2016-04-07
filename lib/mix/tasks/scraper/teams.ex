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
      1..100 |> Enum.each(&add_club/1)
    end
  end

  defp add_club(club_id) do
    Scraper.Club.scrape(club_id)
    changeset = Club.changeset(%Club{}, %{
      name: Scraper.Club.name,
      website_id: club_id,
      logo_url: Scraper.Club.logo
    })
    if Scraper.Club.active? && changeset.valid? do
      {:ok, club} = Repo.insert_or_update(changeset)
      Scraper.Club.interesting_team_ids |> Enum.map(&(add_team(&1, club)))
    end
  end

  defp add_team(team_id, club) do
    Scraper.Team.scrape(team_id)
    changeset = Team.changeset(%Team{}, %{
      name: Scraper.Team.name,
      website_id: team_id,
      level: Scraper.Team.level,
      club_id: club.id
    })
    if Scraper.Team.active? && changeset.valid? do
      Repo.insert_or_update(changeset)
    end
  end

  defp with_hound_session(block) do
    Application.ensure_all_started(:hound)
    Hound.start_session
    block.()
    Hound.end_session
  end
end
