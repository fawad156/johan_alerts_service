defmodule JohanAlertsService.Repo.Migrations.CreateCaregivers do
  use Ecto.Migration

  def change do
    create table(:caregivers) do
      add :phone, :string, null: false
      add :country_code, :string, null: false

      add :health_center_id, references(:health_centers, on_delete: :nothing)

      timestamps()
    end
  end
end
