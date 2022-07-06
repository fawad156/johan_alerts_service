defmodule JohanAlertsService.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :sim_sid, :string, null: false

      add :health_center_id, references(:health_centers, on_delete: :nothing)
      add :patient_id, references(:patients, on_delete: :nothing)

      timestamps()
    end

    create(unique_index(:devices, [:sim_sid], name: :devices_sid_index))
  end
end
