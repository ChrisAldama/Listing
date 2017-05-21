defmodule ListingWeb.SyncTask do
  alias ListingWeb.Property
  alias ListingWeb.Picture
  alias ListingWeb.Repo
  alias ListingWeb.SyncTask
  import Ecto.Query
  require Logger
  @default_time 8 * 1000 * 60 * 60 #8 hours

  def start(interval \\ @default_time) do
    :time.apply_interval(@default_time, &SyncTask.sync/0)
  end

  def sync do
   case Sync.get() do
     {:ok, data} ->
        data
        |> Enum.map(&SyncTask.update_or_insert/1)
        |> Enum.reduce(fn x, acc -> x and acc end)
        |> (&(if &1, do: :ok, else: {:error, "Some register couldn't be inserted"})).()

      {:error, error} = result ->
        Logger.error "Error downloading feeds #{error}"
        result
    end
   end

   def update_or_insert(data) when is_map(data) do
     update_or_insert Property.from_map(data)
   end

   def update_or_insert({fields, pictures}) when is_list(pictures) do

    fields = Map.merge(%{published: true}, fields)
    result =
    case Repo.get_by(Property, raw_id: fields.raw_id) do
        nil -> %Property{}

        property -> property
    end
    |> Property.changeset(fields)
    |> Repo.insert_or_update()

    case result do
      {:ok, property} ->
        insert_pictures(property, pictures)

      {:error, %Ecto.Changeset{errors: errors}} ->
        IO.inspect errors
        false
    end
   end

   def insert_pictures(%Property{} = property, pictures) do
     pictures
     |> Enum.map(&(insert_picture(property.id, &1)))
     |> Enum.reduce(fn r, acc -> r and acc end)
   end

   def insert_picture(property_id, picture) do
     result = %Picture{property_id: property_id}
     |> Picture.changeset(picture)
     |> Repo.insert()

     case result do
       {:ok, _} -> true

       _ -> false
     end

   end

end