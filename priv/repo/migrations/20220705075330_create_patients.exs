defmodule JohanAlertsService.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :first_name, :string
      add :last_name, :string
      add :address, :string
      add :additional_information, :map

      add :health_center_id, references(:health_centers, on_delete: :nothing)

      timestamps()
    end
  end
end
