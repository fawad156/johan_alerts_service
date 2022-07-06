defmodule JohanAlertsService.Patient do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias JohanAlertsService.Repo

  alias JohanAlertsService.Patients.Patient

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients, do: Repo.all(Patient)

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{name: value})
      {:ok, %Patient{}}

      iex> create_patient(%{name: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs \\ %{}) do
    data =
      %Patient{}
      |> Patient.changeset(attrs)
      |> Repo.insert()

    IO.inspect(data)
  end
end
