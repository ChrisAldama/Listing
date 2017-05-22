defmodule ListingWeb.PageController do
  use ListingWeb.Web, :controller
  alias ListingWeb.Repo
  alias ListingWeb.Property
  alias ListingWeb.Pagination
  import Ecto.Query

  @props_per_page 12

  def detail(conn, %{"id" => id}) do
    prop = Repo.get from(p in Property, preload: [:pictures]), id
    render conn, ListingWeb.PropertyView, "show.html", property: prop
  end

  def index(conn, params) do
    count = Repo.aggregate Property, :count, :id
    page = get_page(params)

    props = Repo.all from p in Property,
        preload: [:pictures],
        limit: @props_per_page,
        offset: ^get_offset(page, count),
        where: p.published == true

    context = [properties: props,
               pagination: %Pagination{count: max_pages(count), selected: page}]

    render conn, "index.html", context
  end

  def get_page(params) when is_map(params) do
    case params["page"] do
       page when is_binary(page) -> get_page(page)
        _ -> 1
    end
  end

  def get_page(page) when is_binary(page) do
    case Integer.parse page do
      {n, _} when n > 0 ->
        n
      _ -> 1
    end
  end

  def get_offset(page, count) when count > 0 and page > 0 and page < count do
        @props_per_page * (page - 1)
  end

  @doc "page is not present in the request params"
  def get_offset(_, _), do: 0


  def max_pages(count) do
    Float.ceil count / @props_per_page
  end
end
