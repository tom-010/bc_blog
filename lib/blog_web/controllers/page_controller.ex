defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def index(conn, _params) do
    articles =
    "articles"
    |> ArticleReader.read()
    |> Articles.to_articles()

    render(conn, "index.html", articles: articles)
  end

  def article(conn, _params) do 
    render(conn, "article.html")
  end
end
