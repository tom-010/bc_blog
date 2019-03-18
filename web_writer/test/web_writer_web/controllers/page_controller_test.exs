defmodule WebWriterWeb.PageControllerTest do
  use WebWriterWeb.ConnCase

  @test_dir "test/res"

    setup do 
      CachedArticleRepo.start_link
      File.mkdir("#{@test_dir}")
      System.put_env("ARTICLE_PATH", Path.expand(@test_dir))
      on_exit fn -> File.rm_rf(@test_dir) end
    end

  test "homepage redirects to new-article page", %{conn: conn} do 
    conn = get(conn, "/")
    assert "/new" == redirected_to(conn, 302)
  end

  test "new includes the site title", %{conn: conn} do
    conn = get(conn, "/new")
    assert html_response(conn, 200) =~ "Brutal Coding"
  end

  test "post to save with new article creates new article in repo", %{conn: conn} do 
    post(conn, "/save", %{"title" => "title", "content" => "content"})
    
    articles = CachedArticleRepo.get_articles()
    assert Enum.count(articles) == 1
    
    article = Enum.at(articles, 0)
    assert article.path =~ "title.md"
    assert article.title == "title"
    assert article.content =~ "content"
  end 

  test "put to save with existing article updates it in repo", %{conn: conn} do 
    CachedArticleRepo.save("title", "content")

    put(conn, "/save", %{"title" => "title", "content" => "updated_content"})
    articles = CachedArticleRepo.get_articles()
    assert Enum.count(articles) == 1
    
    article = Enum.at(articles, 0)
    assert article.path =~ "title.md"
    assert article.title == "title"
    assert article.content =~ "updated_content"
  end 

  test "/update includes title and content of existing article", %{conn: conn} do 
    CachedArticleRepo.save("my_title", "my_content")
    conn = get(conn, "/update/my_title")
    assert html_response(conn, 200) =~ "my_title"
    assert html_response(conn, 200) =~ "my_content"
  end 

  test "/update with non-existing article redirects to /new", %{conn: conn} do 
    # no creation of article here. Repo is empty
    conn = get(conn, "/update/non-existing-article")
    assert redirected_to(conn, 302) == "/new"
  end 

  test "/new after save, redirect to /update of created article", %{conn: conn} do 
    conn = post(conn, "/save", %{"title" => "title", "content" => "content"})
    assert redirected_to(conn, 302) == "/update/title"
  end 

  test "/new after save, redirects back to original /update", %{conn: conn} do 
    CachedArticleRepo.save("title", "content")
    conn = put(conn, "/save", %{"title" => "title", "content" => "updated_content"})
    assert redirected_to(conn, 302) == "/update/title"
  end 

end
