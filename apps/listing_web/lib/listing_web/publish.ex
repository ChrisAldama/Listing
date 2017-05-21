defmodule ListingWeb.Publish do
alias ListingWeb.Repo
alias ListingWeb.Property
import Ecto.Query

  def unpublish(data) do
    new_ids = data
    |> Enum.map(fn m -> m.id end)

    old_ids = from(p in Property, select: p.raw_id)
    |> Repo.all()

    to_unpublish = old_ids -- new_ids


    from(p in Property, where: p.raw_id in ^to_unpublish)
    |> Repo.update_all(set: [published: false])

    data
  end

end