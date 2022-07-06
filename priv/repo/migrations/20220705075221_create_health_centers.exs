defmodule JohanAlertsService.Repo.Migrations.CreateHealthCenters do
  use Ecto.Migration

  def change do
    create table(:health_centers) do
      add :name, :string, null: false

      timestamps()
    end

    # create unique_index(:health_centers, [:id])
  end
end
