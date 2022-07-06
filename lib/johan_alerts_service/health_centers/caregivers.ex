defmodule JohanAlertsService.HealthCenters.Caregivers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "caregivers" do
    field :country_code, :string
    field :phone, :string
    # caregiver has one health_center
    belongs_to :health_centers, JohanAlertsService.HealthCenters.HealthCenter,
      foreign_key: :health_center_id,
      type: :integer

    timestamps()
  end

  @doc false
  def changeset(center, attrs) do
    center
    |> cast(attrs, [:phone, :country_code, :health_center_id])
  end
end
