defmodule ListingWeb.Picture do
  use ListingWeb.Web, :model

  schema "pictures" do
    field :picture_url, :string
    belongs_to :property, ListingWeb.Property
    timestamps()

  end

 @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:picture_url, :property_id])
    |> validate_required([:picture_url, :property_id])
  end

end