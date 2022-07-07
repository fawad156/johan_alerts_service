defmodule JohanAlertsService.Alerts.Alert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alerts" do
    field :patient_value, :string
    field :alert_type, :string
    field :incident_dt, :naive_datetime
    field :lat, :float
    field :lon, :float
    field :payload, :map, default: %{}

    belongs_to :devices, JohanAlertsService.HealthCenters.Devices,
      foreign_key: :device_id,
      type: :integer

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:patient_value, :alert_type, :incident_dt, :lat, :lon, :payload, :device_id])
  end
end
