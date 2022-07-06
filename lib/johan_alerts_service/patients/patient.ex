defmodule JohanAlertsService.Patients.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :first_name, :string
    field :last_name, :string
    field :address, :string
    field :additional_information, :map, default: %{}

    # caregiver has one health_center
    belongs_to :health_centers, JohanAlertsService.HealthCenters.HealthCenter,
      foreign_key: :health_center_id,
      type: :integer

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:first_name, :last_name, :address, :additional_information, :health_center_id])
  end
end
