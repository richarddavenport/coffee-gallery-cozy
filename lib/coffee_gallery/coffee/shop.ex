defmodule CoffeeGallery.Coffee.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :name, :string
    field :location, :string
    field :description, :string
    field :image_url, :string
    field :rating, :integer

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name, :location, :description, :image_url, :rating])
    |> validate_required([:name, :location, :description])
    |> validate_length(:name, min: 2, max: 100)
    |> validate_length(:location, min: 2, max: 100)
    |> validate_length(:description, min: 10, max: 500)
    |> validate_url(:image_url)
    |> validate_inclusion(:rating, 1..5)
  end

  defp validate_url(changeset, field) do
    validate_change(changeset, field, fn _, url ->
      case url do
        nil ->
          []

        "" ->
          []

        url when is_binary(url) ->
          if String.match?(url, ~r/^https?:\/\//) do
            []
          else
            [{field, "must be a valid URL starting with http:// or https://"}]
          end

        _ ->
          [{field, "must be a valid URL"}]
      end
    end)
  end
end
