defmodule ListingWeb.PageController do
  use ListingWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
