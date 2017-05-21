defmodule ListingWeb.Repo.Migrations.AddPublishedField do
  use Ecto.Migration

  def change do

    alter table(:properties) do
      add :published, :boolean
    end

  end
end
