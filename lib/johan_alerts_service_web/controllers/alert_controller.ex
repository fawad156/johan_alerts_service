defmodule JohanAlertsServiceWeb.AlertController do
  use JohanAlertsServiceWeb, :controller

  alias JohanAlertsService.Alert
  alias JohanAlertsService.HealthCenter

  @alerts_create_params %{
    status: :string,
    api_version: :string,
    sim_sid: [type: :string, required: true],
    content: [type: :string, required: true],
    direction: :string
  }

  def alerts_create(conn, params) do
    with {:ok, valid_params} <- Tarams.cast(params, @alerts_create_params),
         {:ok, alert_content} <- Alert.fetch_content_data(valid_params),
         device = HealthCenter.get_device_by_sid(valid_params.sim_sid),
         {:ok, device_id} <- HealthCenter.get_device_id(device) do
      alert_content
      |> Map.put(:device_id, device_id)
      |> Map.put(:payload, valid_params)
      |> Alert.create_alert()

      success_response(conn)
    else
      {:error, message} = response ->
        error_response(conn, message)
    end
  end

  def success_response(conn) do
    conn
    |> put_status(:created)
    |> json(%{message: "success"})
  end

  def error_response(conn, message \\ "Wrong params") do
    conn
    |> put_status(400)
    |> json(%{error: message})
  end
end
