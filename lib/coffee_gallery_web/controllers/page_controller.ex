defmodule CoffeeGalleryWeb.PageController do
  use CoffeeGalleryWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
