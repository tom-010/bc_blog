defmodule WebWriterWeb.PageControllerTest do
  use WebWriterWeb.ConnCase

  test "homepage includes the site title", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Brutal Coding"
  end
end
