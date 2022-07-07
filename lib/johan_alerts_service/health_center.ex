defmodule JohanAlertsService.HealthCenter do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias JohanAlertsService.Repo

  alias JohanAlertsService.HealthCenters.{HealthCenter, Devices, Caregivers}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_centers()
      [%HealthCenter{}, ...]

  """
  def list_centers do
    Repo.all(HealthCenter)
  end

  @doc """
  Creates a health center.

  ## Examples

      iex> create_health_center(%{name: value})
      {:ok, %HealthCenter{}}

      iex> create_health_center(%{name: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_health_center(attrs \\ %{}) do
    %HealthCenter{}
    |> HealthCenter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a Caregivers.

  ## Examples

      iex> create_caregivers(%{phone: value, country_code: value})
      {:ok, %Caregivers{}}

      iex> create_caregivers(%{phone: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_caregivers(attrs \\ %{}) do
    %Caregivers{}
    |> Caregivers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a Devices.

  ## Examples

      iex> create_devices(%{sim_sid: value})
      {:ok, %Devices{}}

      iex> create_devices(%{sim_sid: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_devices(attrs \\ %{}) do
    %Devices{}
    |> Devices.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single device.

  Raises `Ecto.NoResultsError` if the device does not exist.

  ## Examples

      iex> get_device!(123)
      %Devices{}

      iex> get_device!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device!(id), do: Repo.get!(Devices, id)
  def get_device_by_sid(sim_sid), do: Repo.get_by(Devices, %{sim_sid: sim_sid})

  def get_device_id(nil), do: {:error, "unknown device"}
  def get_device_id(device), do: {:ok, device.id}
end
