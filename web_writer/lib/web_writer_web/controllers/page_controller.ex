defmodule WebWriterWeb.PageController do
  use WebWriterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do 
    render(conn, "new.html", csrf: get_csrf_token())
  end 

  def update(conn, %{"title" => title} = params) do 
    CachedArticleRepo.start_link
    CachedArticleRepo.refresh
    [article | _] = CachedArticleRepo.get_articles |> Enum.filter(& &1.title == title)
    render(conn, "update.html", csrf: get_csrf_token(), title: article.title, content: File.read!(article.path))
  end 

  def save(conn, %{"content" => content, "title" => title} = params) do
    CachedArticleRepo.save(title, content)
    redirect(conn, to: "/update/#{title}")
  end

end
