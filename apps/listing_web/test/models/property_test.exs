defmodule ListingWeb.PropertyTest do
  use ListingWeb.ModelCase

  alias ListingWeb.Property

  @valid_attrs %{property_type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Property.changeset(%Property{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Property.changeset(%Property{}, @invalid_attrs)
    refute changeset.valid?
  end
end
