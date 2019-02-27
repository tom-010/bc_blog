defmodule BlogWeb.PageControllerTest do
  use BlogWeb.ConnCase

  test "Brutal Coding in Title", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<title>Brutal Coding"
  end

  test "all slugs and names are represented as links to articles", %{conn: conn} do
    conn = get(conn, "/")
    assert_articles(fn article -> 
      assert html_response(conn, 200) =~ "href=\"/article/#{article.slug}\""
      assert html_response(conn, 200) =~ article.name
    end)
  end

  defp articles() do 
    "articles"
    |> ArticleReader.read()
    |> Articles.to_articles()
  end

  defp assert_articles(assert_fn) do
    articles()
    |> Enum.map(& assert_fn.(&1))
  end


  test "links to articles does work", %{conn: conn} do 
    assert_articles(fn article -> 
      article_conn = get(conn, "/article/#{article.slug}")
      assert html_response(article_conn, 200) =~ article.name
    end)
  end
end
