defmodule WebWriterWeb.PageController do
  use WebWriterWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/new")
  end

  def new(conn, _params) do 
    render(conn, "new.html", csrf: get_csrf_token())
  end 

  def update(conn, %{"title" => title} = params) do 
    CachedArticleRepo.start_link
    CachedArticleRepo.refresh
    articles = CachedArticleRepo.get_articles |> Enum.filter(& &1.title == title)
    
    if Enum.count(articles) == 0 do
      redirect(conn, to: "/new")
    else  
      [article | _] = articles
      render(conn, "update.html", csrf: get_csrf_token(), title: article.title, content: File.read!(article.path) |> String.split("\n") |> Enum.slice(3..-1) |> Enum.join("\n"))
    end
  end 

  def save(conn, %{"content" => content, "title" => title} = params) do
    CachedArticleRepo.save(title, content)
    redirect(conn, to: "/update/#{title}")
  end

end
