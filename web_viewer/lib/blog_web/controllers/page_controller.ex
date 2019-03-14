defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  @path_to_posts "../blog_post_res"

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def articles(conn, _params) do
    render(conn, "articles.html", articles: get_articles())
  end

  def article(conn, %{"slug" => slug}) do 
    [article | _] = get_articles() |> Enum.filter(& slug == &1.slug)
    render(conn, "article.html", article: article)
  end

  defp get_articles() do 
    CachedArticleRepo.get_articles()
  end

end
