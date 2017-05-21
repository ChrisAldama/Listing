defmodule ListingWeb.Repo.Migrations.CreatePictures do
  use Ecto.Migration

  def change do

    create table(:pictures) do
        add :property_id, references(:properties)
        add :picture_url, :string

        timestamps()
    end
    create index(:pictures, [:property_id])
  end
end
