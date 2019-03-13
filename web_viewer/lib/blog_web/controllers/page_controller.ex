defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def articles(conn, _params) do
    articles =
    "articles"
    |> ArticleReader.read()
    |> Enum.map(&Article.from_article_file/1)

    render(conn, "articles.html", articles: articles)
  end

  def article(conn, %{"slug" => slug}) do 
    [article | _] =
    "articles"
    |> ArticleReader.read()
    |> Enum.map(&Article.from_article_file/1)
    |> Enum.filter(& slug == &1.slug)

    render(conn, "article.html", article: article, html_content: MarkdownHtmlConverter.convert(article.content))
  end
end
