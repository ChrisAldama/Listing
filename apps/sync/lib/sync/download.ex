defmodule Sync.Download do
  @moduledoc  """
  This module it´s intended to be used for downloaing any feed source
  without format assumtions
  """
  alias HTTPoison.Response
  alias HTTPoison.Error

  @default_source "https://www.stagingeb.com/feeds/d420256874ddb9b6ee5502b9d54e773d8316a695/trovit_MX.xml.gz"

  @doc "Macro for match a http response with especific body and status code"
  defmacro get_body(status, body) do
    quote do
      {:ok, %Response{status_code: unquote(status), body: unquote(body)}}
    end
  end

  @doc "Macro for match a http error with especific body and status code"
  defmacro get_error(reason) do
    quote do
      {:error, %Error{reason: unquote(reason)}}
    end
  end

  @doc "Function to download a feed source and handle errors"
  def feed(source \\ @default_source) do
    case HTTPoison.get(source) do
      get_body(200, body) ->
        {:ok, body}

      get_body(_, body) ->
        {:error, body}

      get_error(reason) ->
        {:error, reason}

      error ->
        {:error, error}
    end
  end

  def compressed_feed(source \\ @default_source) do
    case feed source do
      {:ok, data} ->
         {:ok, :zlib.gunzip(data)}
      error ->
        error
    end
  end

end