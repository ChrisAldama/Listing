defmodule ListingWeb.PropertyView do
  use ListingWeb.Web, :view
  alias ListingWeb.Property
  alias ListingWeb.Picture

  def get_image(%Property{} = property) do
    case property.pictures do
      [p = %Picture{} | _] ->  p.picture_url

      _ -> "/images/no_home.png"
    end
  end
end
