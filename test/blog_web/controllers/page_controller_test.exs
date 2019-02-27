defmodule BlogWeb.PageControllerTest do
  use BlogWeb.ConnCase

  test "Brutal Coding in Title", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<title>Brutal Coding"
  end

  test "links to articles", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "href=\"/article/thank-you-for-the-big-effort-of-writing-such-an-extensive-answer_\""
  end
end
