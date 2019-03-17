defmodule WebWriterWeb.PageControllerTest do
  use WebWriterWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Brutal Coding"
  end
end
