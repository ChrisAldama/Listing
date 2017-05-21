defmodule Sync.Parser.Xml do
  @moduledoc """
  This module implements the Parser behaviour for Xml feeds
  """
  @behaviour Sync.Parser
  import SweetXml

  def parse(str) do
    str
    |> xpath(~x"//trovit/ad"l, matches())

  end


  defp matches() do
    [
    property_type: ~x"./property_type/text()"s,
    id: ~x"./id/text()"s,
    url: ~x"./url/text()"s,
    title: ~x"./title/text()"s,
    content: ~x"./content/text()"s,
    type: ~x"./type/text()"s,
    agency: ~x"./agency/text()"s,
    price_currency: ~x"./price/@currency"s,
    price: ~x"./price/text()"of,
    floor_area_unit:  ~x"./floor_area/@unit"s,
    floor_area: ~x"./floor_area/text()"of,
    rooms: ~x"./rooms/text()"oi,
    bathrooms: ~x"./bathrooms/text()"oi,
    city: ~x"./city/text()"s,
    city_area: ~x"./city_area/text()"s,
    region: ~x"./region/text()"s,
    longitude: ~x"./longitude/text()"of,
    latitude: ~x"./latitude/text()"of,
    pictures: [~x"./pictures/picture"l,
               picture: [~x".", url: ~x"./picture_url/text()"s]],
    date: ~x"./date/text()"s,
    time: ~x"./time/text()"s
    ]
  end
end