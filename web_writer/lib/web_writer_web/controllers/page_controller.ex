defmodule WebWriterWeb.PageController do
  use WebWriterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
