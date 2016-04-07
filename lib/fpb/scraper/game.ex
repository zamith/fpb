defmodule Fpb.Scraper.Game do
  use Hound.Helpers

  def scrape(game_id) do
    navigate_to "http://www.fpb.pt/fpb2014/!site.go?s=1&show=jog&id=#{game_id}"
  end
end
