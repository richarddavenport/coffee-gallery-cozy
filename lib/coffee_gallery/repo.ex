defmodule CoffeeGallery.Repo do
  use Ecto.Repo,
    otp_app: :coffee_gallery,
    adapter: Ecto.Adapters.SQLite3
end
