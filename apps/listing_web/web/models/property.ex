defmodule ListingWeb.Property do
  use ListingWeb.Web, :model

  schema "properties" do
    field :property_type, :string
    field :raw_id, :string
    field :url, :string
    field :title, :string
    field :content, :string
    field :type, :string
    field :agency, :string
    field :price_currency, :string
    field :price, :float
    field :floor_area_unit, :string
    field :floor_area, :float
    field :rooms, :integer
    field :bathrooms, :integer
    field :city, :string
    field :city_area, :string
    field :region, :string
    field :longitude, :float
    field :latitude, :float
    field :date, Ecto.Date
    field :time, Ecto.Time
    field :published, :boolean

    has_many :pictures, ListingWeb.Picture

    timestamps()
  end

  @valid_fields [:property_type, :raw_id, :url, :title, :content, :type, :agency,:price_currency,
    :price, :floor_area_unit, :floor_area, :rooms, :bathrooms, :city, :city_area, :region,
    :longitude, :latitude, :date, :time]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_fields)
    |> validate_required([])
  end

  def from_map(map) when is_map(map) do
    pictures = map.pictures
    |> Enum.map(fn p -> %{picture_url: p.picture.url} end)

    [day, month, year] = String.split(map.date, "/")
    [hour, minute] = String.split(map.time, ":")
    property = map
    |> Map.merge(%{raw_id: map.id, date: {year, month, day}, time: {hour, minute, 0}})

    {property, pictures}
  end
end
