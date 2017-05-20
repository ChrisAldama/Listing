defmodule Sync.Parser.Xml do
  @moduledoc """
  This module implements the Parser behaviour for Xml feeds
  """
  @behaviour Sync.Parser
  import SweetXml

  def parse(str) do
    xpath str, ~x"//trovit/ad"l, matches()
  end

  defp matches() do
    [
    property_type: ~x"./property_type/text()",
    id: ~x"./id/text()",
    url: ~x"./url/text()",
    title: ~x"./title/text()",
    content: ~x"./content/text()",
    type: ~x"./type/text()",
    agency: ~x"./agency/text()",
    price: [~x".",
            currency: ~x"./price/@currency",
            amount: ~x"./price/text()"],
    floor_area: [~x".",
                 unit: ~x"./floor_area/@unit",
                 amount: ~x"./floor_area/text()"],
    rooms: ~x"./rooms/text()",
    bathrooms: ~x"./bathrooms/text()",
    city: ~x"./city/text()",
    city_area: ~x"./city_area/text()",
    region: ~x"./region/text()",
    longitude: ~x"./longitude/text()",
    latitude: ~x"./latitude/text()",
    pictures: [~x"./pictures/picture"l,
               picture: [~x".", url: ~x"./picture_url/text()"]],
    date: ~x"./date/text()",
    time: ~x"./time/text()"
    ]
  end
end