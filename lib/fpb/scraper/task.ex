defmodule Fpb.Scraper.Task do
  defmacro __using__(_) do
    quote do
      defp with_hound_session(block) do
        Application.ensure_all_started(:hound)
        Hound.start_session
        block.()
        Hound.end_session
      end
    end
  end
end
