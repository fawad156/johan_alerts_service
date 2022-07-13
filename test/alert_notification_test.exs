defmodule AlertNotificationTest do
  use ExUnit.Case, async: true
  import JohanAlertsService.AlertNotification

  @caregivers [%{country_code: "0031", health_center_id: 1, id: 1, phone: "0433876543"}]
  @patient %{
    additional_information: %{"general_info" => "keys are outside", "patient_condition" => "Sick"},
    address: "Netherland",
    health_center_id: 2,
    id: 2,
    first_name: "Mr",
    last_name: "john"
  }
  @alert %{
    incident_dt: "2015-07-30T20:00:00Z",
    patient_value: 200,
    alert_type: "BPM",
    lat: 52.15,
    lon: 4.29
  }
  @twilio_message %{body: "", from: '+15017122661', to: ""}

  describe "send_notification/3 When params are valid then return :ok and send message else return :error with message" do
    test "Doing send notification when patient not exist", %{} do
      send_notification(nil, @caregivers, @alert) == {:error, "No patient found"}
    end

    test "Doing send notification when caregivers not exist", %{} do
      send_notification(@patient, [], @alert) == {:error, "No caregivers found"}
    end

    test "Doing send notification when patient & caregivers not exist", %{} do
      send_notification(nil, [], @alert) == {:error, "No patient & caregivers found"}
    end

    test "Doing send notification when params are valid", %{} do
      send_notification(@patients, @caregivers, @alert) == {:ok, "00310433876543"}
    end
  end
end
