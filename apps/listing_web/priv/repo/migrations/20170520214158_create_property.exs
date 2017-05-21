defmodule ListingWeb.Repo.Migrations.CreateProperty do
  use Ecto.Migration

  def change do

    create table(:properties) do
      add :property_type, :string
      add :raw_id, :string
      add :url, :string
      add :title, :string
      add :content, :string
      add :type, :string
      add :agency, :string
      add :price_currency, :string
      add :price, :float
      add :floor_area_unit, :string
      add :floor_area, :float
      add :rooms, :integer
      add :bathrooms, :integer
      add :city, :string
      add :city_area, :string
      add :region, :string
      add :longitude, :float
      add :latitude, :float
      add :date, :date
      add :time, :time

      timestamps()
    end

    create index(:properties, [:city, :city_area, :region])
    create index(:properties, [:date, :time])
    create index(:properties, [:agency])
    create index(:properties, [:property_type])
    create index(:properties, [:price_currency, :price])

  end
end
