defmodule CoffeeGalleryWeb.AdminLive do
  use CoffeeGalleryWeb, :live_view

  alias CoffeeGallery.Coffee
  alias CoffeeGallery.Coffee.Shop

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(CoffeeGallery.PubSub, "coffee_shops")
    end

    shops = Coffee.list_shops()

    {:ok,
     socket
     |> assign(:shops_empty?, shops == [])
     |> stream(:shops, shops)
     |> assign_new_shop_form()}
  end

  @impl true
  def handle_event("validate", %{"shop" => shop_params}, socket) do
    changeset =
      %Shop{}
      |> Coffee.change_shop(shop_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  @impl true
  def handle_event("save", %{"shop" => shop_params}, socket) do
    case Coffee.create_shop(shop_params) do
      {:ok, shop} ->
        Phoenix.PubSub.broadcast(CoffeeGallery.PubSub, "coffee_shops", {:shop_created, shop})

        {:noreply,
         socket
         |> assign(:shops_empty?, false)
         |> stream_insert(:shops, shop, at: 0)
         |> assign_new_shop_form()
         |> put_flash(:info, "Coffee shop added successfully!")}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  @impl true
  def handle_event("delete_shop", %{"id" => id}, socket) do
    shop = Coffee.get_shop!(id)
    {:ok, _} = Coffee.delete_shop(shop)

    Phoenix.PubSub.broadcast(CoffeeGallery.PubSub, "coffee_shops", {:shop_deleted, shop})

    shops = Coffee.list_shops()

    {:noreply,
     socket
     |> assign(:shops_empty?, shops == [])
     |> stream_delete(:shops, shop)
     |> put_flash(:info, "Coffee shop removed successfully!")}
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

  defp assign_new_shop_form(socket) do
    changeset = Coffee.change_shop(%Shop{})
    assign(socket, form: to_form(changeset))
  end
end
