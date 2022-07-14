defmodule JohanAlertsServiceWeb.AlertController do
  use JohanAlertsServiceWeb, :controller

  alias JohanAlertsService.{Alert, AlertNotification, HealthCenter, Patient}

  @alerts_create_params %{
    status: :string,
    api_version: :string,
    sim_sid: [type: :string, required: true],
    content: [type: :string, required: true],
    direction: :string
  }

  @default_page 1

  def alerts_create(conn, params) do
    with {:ok, valid_params} <- Tarams.cast(params, @alerts_create_params),
         {:ok, alert} <- Alert.fetch_content_data(valid_params),
         {:ok, alert_content} <- Alert.alert_type_verify(alert),
         device = HealthCenter.get_device_by_sid(valid_params.sim_sid),
         {:ok, device_id} <- HealthCenter.get_device_id(device) do
      alert_content
      |> Map.put(:device_id, device_id)
      |> Map.put(:payload, valid_params)
      |> Alert.create_alert()

      # send notification to caregives
      patient = Patient.get_patient(device.patient_id)
      caregivers = HealthCenter.get_caregivers_by_health_id(device.health_center_id)

      Task.async(fn -> AlertNotification.send_notification(patient, caregivers, alert_content) end)

      success_response(conn)
    else
      {:error, message} = response ->
        error_response(conn, message)
    end
  end

  def get_alerts(conn, params) do
    alerts =
      params
      |> update_alert_params()
      |> Alert.list_alerts()

    page = Map.get(params, "page", @default_page)

    conn
    |> put_status(:ok)
    |> json(%{alerts: alerts, page: page})
  end

  defp update_alert_params(params) do
    page = Map.get(params, "page", @default_page) |> convert_integer()
    at_dt = Map.get(params, "at_dt", nil)
    type_key = Map.get(params, "type_key", nil)
    params |> Map.put("page", page) |> Map.put("at_dt", at_dt) |> Map.put("type_key", type_key)
  end

  defp convert_integer(page) when is_binary(page), do: String.to_integer(page)
  defp convert_integer(page), do: page

  defp success_response(conn) do
    conn
    |> put_status(:created)
    |> json(%{message: "success"})
  end

  defp error_response(conn, message \\ "Wrong params") do
    conn
    |> put_status(400)
    |> json(%{error: message})
  end
end
