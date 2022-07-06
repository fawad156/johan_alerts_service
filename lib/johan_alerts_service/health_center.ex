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
    data = Repo.all(HealthCenter)
    IO.inspect(data, label: "data")
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
    data =
      %Caregivers{}
      |> Caregivers.changeset(attrs)
      |> Repo.insert()

    IO.inspect(data)
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
    data =
      %Devices{}
      |> Devices.changeset(attrs)
      |> Repo.insert()

    IO.inspect(data)
  end
end
