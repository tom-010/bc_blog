defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def index(conn, _params) do
    articles =
    "articles"
    |> ArticleReader.read()
    |> Articles.to_articles()

    render(conn, "index.html", articles: articles)
  end

  def articles(conn, _params) do
    articles =
    "articles"
    |> ArticleReader.read()
    |> Articles.to_articles()

    render(conn, "articles.html", articles: articles)
  end

  def article(conn, %{"slug" => slug}) do 
    [article | _] =
    "articles"
    |> ArticleReader.read()
    |> Articles.to_articles()
    |> Enum.filter(& slug == &1.slug)

    render(conn, "article.html", article: article, html_content: Article.html(article))
  end
end
