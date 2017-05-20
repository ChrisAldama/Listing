defmodule Sync.Parser do
  @moduledoc """
    Parser behaviour.

    The parse callback expects a string with the raw values,
    and returns a list of maps with the parsed values
  """

  @callback parse(String.t) :: List.t
end