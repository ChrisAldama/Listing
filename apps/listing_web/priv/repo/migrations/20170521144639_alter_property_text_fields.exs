defmodule ListingWeb.Repo.Migrations.AlterPropertyTextFields do
  use Ecto.Migration

  def change do
    alter table(:properties) do
        modify :url, :string, size: 512
        modify :content, :text
    end
  end
end
