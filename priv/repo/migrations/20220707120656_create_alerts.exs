defmodule JohanAlertsService.Repo.Migrations.CreateAlerts do
  use Ecto.Migration

  def change do
    create table(:alerts) do
      add :patient_value, :string
      add :alert_type, :string
      add :incident_dt, :naive_datetime
      add :lat, :float
      add :lon, :float
      add :payload, :map

      add :device_id, references(:devices, on_delete: :nothing)

      timestamps()
    end
  end
end
