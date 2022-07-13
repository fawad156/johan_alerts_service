defmodule Doctest do
  use ExUnit.Case, async: true
  import JohanAlertsService.AlertNotification
  doctest JohanAlertsService.AlertNotification
end
