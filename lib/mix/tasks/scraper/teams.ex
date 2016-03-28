defmodule Mix.Tasks.Scrapper.Teams do
  use Mix.Task
  import Fpb.Scraper

  def run(_args) do
    team_id = 100
    Fpb.Scraper.scrape("http://www.fpb.pt/fpb2014/!site.go?s=1&show=equ&id=#{team_id}")
  end
end
