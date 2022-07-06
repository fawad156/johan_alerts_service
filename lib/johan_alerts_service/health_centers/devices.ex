defmodule JohanAlertsService.HealthCenters.Devices do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :sim_sid, :string

    # device has one health_center
    belongs_to :health_centers, JohanAlertsService.HealthCenters.HealthCenter,
      foreign_key: :health_center_id,
      type: :integer

    # device has one Patient
    belongs_to :patients, JohanAlertsService.Patients.Patient,
      foreign_key: :patient_id,
      type: :integer

    timestamps()
  end

  @doc false
  def changeset(devices, attrs) do
    devices
    |> cast(attrs, [:sim_sid, :health_center_id, :patient_id])
    |> validate_required([:sim_sid, :health_center_id])
    |> unique_constraint(:sim_sid)
  end
end
