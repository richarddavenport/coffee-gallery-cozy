defmodule CoffeeGalleryWeb.GalleryLive do
  use CoffeeGalleryWeb, :live_view

  alias CoffeeGallery.Coffee

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(CoffeeGallery.PubSub, "coffee_shops")
    end

    shops = Coffee.list_shops()

    {:ok,
     socket
     |> assign(:shops_empty?, shops == [])
     |> stream(:shops, shops)}
  end

  @impl true
  def handle_info({:shop_created, shop}, socket) do
    {:noreply,
     socket
     |> assign(:shops_empty?, false)
     |> stream_insert(:shops, shop, at: 0)}
  end

  @impl true
  def handle_info({:shop_deleted, shop}, socket) do
    shops = Coffee.list_shops()

    {:noreply,
     socket
     |> assign(:shops_empty?, shops == [])
     |> stream_delete(:shops, shop)}
  end
end
