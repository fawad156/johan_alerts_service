defmodule JohanAlertsService.Alert do
  @moduledoc """
  The Alert context.
  """

  import Ecto.Query, warn: false
  alias JohanAlertsService.Repo
  alias JohanAlertsService.Alerts.Alert

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

  def alert_structure(%{DT: dt, LAT: lat, LON: lon, T: type, VAL: val} = _updated_map) do
    {:ok,
     %{
       incident_dt: dt,
       patient_value: val,
       alert_type: type,
       lat: lat,
       lon: lon
     }}
  end

  def alert_structure(_updated_map) do
    {:error, "content keys error"}
  end
end
