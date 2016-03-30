defmodule Fpb.Scraper do
  def scrape(url) do
    HTTPotion.get(url).body
    |> parse
  end

  def parse(html) do
    Floki.find(html, ".BlockContainer01z #dEquipa_Ficha_Home_Jog")
  end
end
