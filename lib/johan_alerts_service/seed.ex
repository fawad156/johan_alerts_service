defmodule JohanAlertsService.Seed do
  alias JohanAlertsService.Repo

  alias JohanAlertsService.HealthCenter, as: HealthCenter
  alias JohanAlertsService.Patient

  def seed_data() do
    seed_health_centers()
    cg = Task.async(fn -> seed_caregivers() end)
    pt = Task.async(fn -> seed_patients() end)
    Task.await(cg, :infinity)
    Task.await(pt, :infinity)
    dc = Task.async(fn -> seed_devices() end)
    Task.await(dc, :infinity)
  end

  def seed_health_centers() do
    health_centers()
    |> Enum.each(fn a ->
      HealthCenter.create_health_center(a)
    end)
  end

  def seed_caregivers() do
    health_centers = HealthCenter.list_centers()

    care_givers()
    |> Enum.map(fn c ->
      random_number = Enum.random([0, 1])
      health_center_id = Enum.at(health_centers, random_number) |> Map.get(:id)
      c = Map.put(c, :health_center_id, health_center_id)
      HealthCenter.create_caregivers(c)
    end)
  end

  def seed_patients() do
    health_centers = HealthCenter.list_centers()

    patients()
    |> Enum.map(fn c ->
      random_number = Enum.random([0, 1])
      health_center_id = Enum.at(health_centers, random_number) |> Map.get(:id)
      c = Map.put(c, :health_center_id, health_center_id)
      Patient.create_patient(c)
    end)
  end

  def seed_devices() do
    health_centers = HealthCenter.list_centers()
    patients = Patient.list_patients()

    devices()
    |> Enum.with_index(fn element, index ->
      random_number = Enum.random([0, 1])
      health_center_id = Enum.at(health_centers, random_number) |> Map.get(:id)
      patient_id = Enum.at(patients, index) |> Map.get(:id)

      device =
        element
        |> Map.put(:health_center_id, health_center_id)
        |> Map.put(:patient_id, patient_id)

      HealthCenter.create_devices(device)
    end)
  end

  def health_centers() do
    [
      %{name: "Maastricht, UMC"},
      %{name: "Nijmegen, Radboud UMC"}
    ]
  end

  def care_givers() do
    [
      %{phone: "0433876543", country_code: "0031"},
      %{phone: "0243611111", country_code: "0031"},
      %{phone: "0107040704", country_code: "0031"}
    ]
  end

  def patients() do
    [
      %{
        first_name: "Mr",
        last_name: "clark",
        address: "Netherland",
        additional_information: %{"patient_condition" => "", "general_info" => ""}
      },
      %{
        first_name: "Mr",
        last_name: "john",
        address: "Netherland",
        additional_information: %{"patient_condition" => "", "general_info" => ""}
      },
      %{
        first_name: "Mr",
        last_name: "alex",
        address: "Netherland",
        additional_information: %{"patient_condition" => "", "general_info" => ""}
      },
      %{
        first_name: "Mr",
        last_name: "erick",
        address: "Netherland",
        additional_information: %{"patient_condition" => "", "general_info" => ""}
      }
    ]
  end

  def devices() do
    [
      %{sim_sid: "DELKMNOPQRSTU"},
      %{sim_sid: "QRSTUDELKMNOP"},
      %{sim_sid: "STUQRKMNOPDEL"}
    ]
  end
end
