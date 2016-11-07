defmodule Fpb.TeamsScrapperTaskTest do
  import Ecto.Query
  use Fpb.ConnCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias Fpb.Club

  test "adds a club that is active" do
    use_cassette "one_active_club" do
      HTTPoison.start
      Mix.Tasks.Scraper.Teams.run([])

      club = Repo.one(from c in Club, order_by: [desc: c.id], limit: 1)
      assert club != nil
    end
  end
end
