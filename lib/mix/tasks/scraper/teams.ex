defmodule Mix.Tasks.Scrapper.Teams do
  use Mix.Task

  def run(_args) do
    HTTPotion.start
    team_id = 100
    IO.inspect Fpb.Scraper.scrape("http://www.fpb.pt/fpb2014/!site.go?s=1&show=equ&id=#{team_id}")
  end
end
