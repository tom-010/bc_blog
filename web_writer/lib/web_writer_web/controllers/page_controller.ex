defmodule WebWriterWeb.PageController do
  use WebWriterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do 
    render(conn, "new.html", csrf: get_csrf_token())
  end 

  def update(conn, _params) do 
    render(conn, "new.html", csrf: get_csrf_token(), title: )
  end 

  def save(conn, %{"content" => content, "title" => title} = params) do
    # IO.puts("saving #{params.title} with content #{params.content}")
    IO.inspect(content)
    IO.inspect(title)
    IO.inspect(params)
    redirect(conn, to: "/update")
  end

end
