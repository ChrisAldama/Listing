defmodule Sync do

  def get do
    case Sync.Download.compressed_feed() do
        {:ok, data} ->
            {:ok, Sync.Parser.Xml.parse(data)}

        error ->
            error
    end
  end
end
