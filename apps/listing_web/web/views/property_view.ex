defmodule ListingWeb.PropertyView do
  use ListingWeb.Web, :view
  alias ListingWeb.Property
  alias ListingWeb.Picture
  require Money

  def get_image(%Property{} = property) do
    case property.pictures do
      [p = %Picture{} | _] ->  p.picture_url

      _ -> "/images/no_home.png"
    end
  end

  def format_price(val, currency) when is_float(val) do
    val
    |> (fn m -> round(m * 100) end).()
    |> Money.new(String.to_atom currency)
    |> Money.to_string()
    |> (fn n -> "#{n} #{currency}" end).()
  end

  def format_price(_, _), do: nil

  def get_address(prop) do
    "#{prop.region}, #{prop.city} #{prop.city_area}"
  end

  def get_area(prop) do
    "#{prop.floor_area} #{prop.floor_area_unit}"
  end
end
