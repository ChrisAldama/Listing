defmodule ListingWeb.PageView do
  use ListingWeb.Web, :view
  alias ListingWeb.Pagination

  @default_pages 5

  def previous(%Pagination{count: c, selected: s}) when c > 0 and s > 1, do: :enabled
  def previous(_), do: :disabled

  def next(%Pagination{count: c, selected: s}) when c != s, do: "enabled"
  def next(_), do: "disabled"

  def build(%Pagination{count: c, selected: s}) when s < @default_pages/2 do
    [build(1, @default_pages, s),
     ellipsis(),
     pagination_link(round(c), s)]
  end

  def build(%Pagination{count: c, selected: s}) when s > c - @default_pages + 1 do
   [pagination_link(1, s),
    ellipsis(),
    build(c - @default_pages + 1, c, s)]
  end

  def build(%Pagination{count: c, selected: s})  do
    amount = (@default_pages/2)

    [pagination_link(1, s),
     ellipsis(),
     build(s - amount, s + amount - 1, s),
     ellipsis(),
     pagination_link(round(c), s)]
  end

  def build(min, max, selected) do
    round(min)..round(max)
    |> Enum.map(&ListingWeb.PageView.pagination_link(&1, selected))
  end

  def pagination_link(n, selected) do
    ~E"""
      <li>
        <a href="/?page=<%= n %>" class="pagination-link <%= if n == selected, do: "is-current" %>">
           <%= n %>
        </a>
      </li>
    """
  end

  def ellipsis do
    ~E"""
      <li>
        <span class="pagination-ellipsis">&hellip;</span>
      <li>
    """
  end
end
