defmodule JohanAlertsService.AlertNotification do
  @moduledoc """
  The Alert Notification context.

   ## Examples
   iex> caregivers = [%{country_code: "0031",health_center_id: 1,id: 1,phone: "0433876543"}]
   iex> send_notification(nil,caregivers,%{})
   {:error, "No patient found"}

   
   iex> send_notification(nil,[],%{})
   {:error, "No patient & caregivers found"}

   iex> patient = %{additional_information: %{"general_info" => "keys are outside", "patient_condition" => "Sick"},address: "Netherland",health_center_id: 2,id: 2,first_name: "Mr",last_name: "john"}
   iex> send_notification(patient,[],%{})
   {:error, "No caregivers found"}

   iex> patient = %{additional_information: %{"general_info" => "keys are outside", "patient_condition" => "Sick"},address: "Netherland",health_center_id: 2,id: 2,first_name: "Mr",last_name: "john"}
   iex> send_notification(patient,[%{country_code: "0031",health_center_id: 1,id: 1,phone: "0433876543"}],%{incident_dt: "2015-07-30T20:00:00Z" ,patient_value: 200,alert_type: "BPM",lat: 52.15,lon: 4.29})
   :ok
  """

  def send_notification(nil, [], _alerts) do
    {:error, "No patient & caregivers found"}
  end

  def send_notification(nil, _caregivers, _alerts) do
    {:error, "No patient found"}
  end

  def send_notification(_patient, [], _alerts) do
    {:error, "No caregivers found"}
  end

  def send_notification(patient, caregivers, alerts) do
    sms_content = sms_prepare(patient, alerts)
    Enum.each(caregivers, fn x -> send_twilio(sms_content, x) end)
  end

  defp sms_prepare(patient, %{incident_dt: incident_dt, alert_type: alert_type}) do
    info = convert_map_to_string(patient.additional_information)

    "ALERT patient name=#{patient.first_name} #{patient.last_name} DT=#{incident_dt} T=#{alert_type} info=#{info}"
  end

  defp convert_map_to_string(additional_information) do
    Enum.map_join(additional_information, ", ", fn {key, val} -> ~s{"#{key}", "#{val}"} end)
  end

  @doc """
  send_twilio/2 receive two args 1) sms content 2) caregiver info
  Create message body and then return receptient phone number

  iex> caregiver=%{country_code: "0031", health_center_id: 1, id: 1, phone: "0433876543"}
  iex> send_twilio("ALERT patient name=Mr john DT=2015-07-30T20:00:00Z T=BPM info=general_info, keys are outside, patient_condition, Sick",caregiver)
  {:ok,"00310433876543"}
  """
  def send_twilio(sms_content, %{country_code: country_code, phone: phone} = _caregiver) do
    twilio = %{
      body: sms_content,
      from: '+15017122661',
      to: country_code <> phone
    }

    {:ok, twilio.to}
  end
end
