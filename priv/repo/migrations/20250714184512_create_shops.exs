defmodule CoffeeGallery.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :string, null: false
      add :location, :string, null: false
      add :description, :text, null: false
      add :image_url, :string
      add :rating, :integer

      timestamps()
    end

    create index(:shops, [:name])
    create index(:shops, [:location])
  end
end
