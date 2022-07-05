defmodule JohanAlertsService.Repo do
  use Ecto.Repo,
    otp_app: :johan_alerts_service,
    adapter: Ecto.Adapters.Postgres
end
