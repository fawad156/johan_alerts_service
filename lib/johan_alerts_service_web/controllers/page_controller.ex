defmodule JohanAlertsServiceWeb.PageController do
  use JohanAlertsServiceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
