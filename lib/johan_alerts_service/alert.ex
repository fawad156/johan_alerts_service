defmodule JohanAlertsService.Alert do
  @moduledoc """
  The Alert context.
  """

  import Ecto.Query, warn: false
  alias JohanAlertsService.Repo
  alias JohanAlertsService.Alerts.Alert

  @callback alerts_filter_by_date_type(integer, String.t(), String.t()) ::
              {:ok, list()} | {:error, any()}

  defp paginate(query, page, per_page \\ 15) do
    from query,
      limit: ^per_page,
      offset: (^page - 1) * ^per_page
  end

  defp alerts_filter_by_date_type(page, nil, nil) do
    from(a in Alert) |> paginate(page) |> Repo.all()
  end

  defp alerts_filter_by_date_type(page, nil, type_key) do
    Alert |> where([a], a.alert_type == ^type_key) |> paginate(page) |> Repo.all()
  end

  defp alerts_filter_by_date_type(page, at_dt, nil) do
    Alert |> where([a], a.incident_dt == ^at_dt) |> paginate(page) |> Repo.all()
  end

  defp alerts_filter_by_date_type(page, at_dt, type_key) do
    Alert
    |> where([a], a.incident_dt == ^at_dt and a.alert_type == ^type_key)
    |> paginate(page)
    |> Repo.all()
  end

  @doc """
  Returns the list of alerts.

  ## Examples

      iex> list_alerts()
      [%Alert{}, ...]

  """
  def list_alerts(%{"page" => page, "at_dt" => incident_dt, "type_key" => type_key} = _params) do
    alerts_filter_by_date_type(page, incident_dt, type_key) |> parse_alerts_payload()
  end

  defp parse_alerts_payload(alerts) do
    Enum.map(alerts, fn alert ->
      parse_single_alert_payload(alert)
    end)
  end

  defp parse_single_alert_payload(alert) do
    %{
      id: alert.id,
      patient_value: alert.patient_value,
      alert_type: alert.alert_type,
      incident_dt: alert.incident_dt,
      lat: alert.lat,
      lon: alert.lon,
      device_id: alert.device_id
    }
  end

  @doc """
  Creates a alert.

  ## Examples

      iex> create_alert(%{key: value})
      {:ok, %Alert{}}

      iex> create_alert(%{key: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_alert(attrs \\ %{}) do
    %Alert{}
    |> Alert.changeset(attrs)
    |> Repo.insert()
  end

  def fetch_content_data(%{content: content} = params) do
    new_value =
      content
      |> String.split(" ", trim: true)
      |> Enum.map(fn chunk ->
        if chunk != "ALERT", do: String.split(chunk, "=", trim: true)
      end)
      |> Enum.reject(&is_nil/1)

    content_map = for [k, v] <- new_value, into: %{}, do: {String.to_atom(k), v}
    alert_structure(content_map)
  end

  defp alert_structure(%{DT: dt, LAT: lat, LON: lon, T: type, VAL: val} = _updated_map) do
    {:ok,
     %{
       incident_dt: dt,
       patient_value: val,
       alert_type: type,
       lat: lat,
       lon: lon
     }}
  end

  defp alert_structure(_updated_map) do
    {:error, "content keys error"}
  end

  def alert_type_verify(%{alert_type: "BPM"} = alert), do: {:ok, alert}
  def alert_type_verify(%{alert_type: "TEMP"} = alert), do: {:ok, alert}
  def alert_type_verify(%{alert_type: "FALL"} = alert), do: {:ok, alert}
  def alert_type_verify(%{alert_type: _alert_type} = _alert), do: {:error, "unknown alert type"}
end
