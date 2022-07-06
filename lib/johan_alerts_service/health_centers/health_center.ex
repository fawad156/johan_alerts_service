defmodule JohanAlertsService.HealthCenters.HealthCenter do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :id
  schema "health_centers" do
    field :name, :string

    # health_center has many caregivers
    has_many :caregivers, JohanAlertsService.HealthCenters.Caregivers

    # health_center has many devices
    has_many :devices, JohanAlertsService.HealthCenters.Devices

    # health_center has many patients
    has_many :patients, JohanAlertsService.Patients.Patient

    timestamps()
  end

  @doc false
  def changeset(center, attrs) do
    center
    |> cast(attrs, [:name])
  end
end
