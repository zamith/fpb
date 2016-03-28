defmodule Fpb.Scraper do
  def scrape(url) do
    HTTPotion.start
    HTTPotion.get(url)
  end
end
