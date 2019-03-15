defmodule CachedArticleRepoTest do
  use ExUnit.Case
  doctest CachedArticleRepo

  @test_dir "test/res"

  setup do
    System.put_env("ARTICLE_PATH", @test_dir)
    prepare_dirs()
    CachedArticleRepo.start_link()
    on_exit fn -> 
      CachedArticleRepo.clear()
      clean() 
    end
    :ok
  end

  test "non-existing path empty article-list" do 
    System.put_env("ARTICLE_PATH", "this/path/does/not/exist")
    assert CachedArticleRepo.get_articles() == []
  end

  test "cached article repo" do 
    create_article("some article")
    CachedArticleRepo.refresh()
    articles = CachedArticleRepo.get_articles()
    assert Enum.count(articles) == 1
    assert Enum.at(articles, 0).title == "some article"
  end

  test "multiple articles in dir" do 
    create_article("one article")
    create_article("other article")
    CachedArticleRepo.refresh()
    articles = CachedArticleRepo.get_articles()
    assert Enum.count(articles) == 2
  end

  test "without cache-busting, the article returned gets not updated" do 
    create_article("some article")
    CachedArticleRepo.refresh()
    articles = CachedArticleRepo.get_articles()
    update_aricle("some article", "new content")
    new_articles = CachedArticleRepo.get_articles()
    assert articles == new_articles # unchanged    
  end

  test "with cache-busting, updated article ist returned" do 
    create_article("some article")
    CachedArticleRepo.refresh()
    update_aricle("some article", "new content")
    CachedArticleRepo.refresh()
    new_articles = CachedArticleRepo.get_articles()
    assert Enum.at(new_articles, 0).content =~ "new content"
  end 

  test "clear removes all artilces" do 
    create_article("1")
    create_article("2")
    create_article("3")
    CachedArticleRepo.refresh()
    assert CachedArticleRepo.get_articles() |> Enum.count > 0
    CachedArticleRepo.clear()
    assert CachedArticleRepo.get_articles() |> Enum.count == 0
  end

  defp update_aricle(title, content) do 
    create_article(title, content);
  end

  defp create_article(title) do 
    create_article(title, title)
  end

  defp create_article(title, content) do 
    File.write("#{@test_dir}/category1/#{title}.md", """
    #{title}
    ========

    |info  |               |
    |------|---------------|
    |date  |01.01.2019     |
    |author|Thomas Deniffel|
    |key 1 | val 1         |
    |tags  |tag1,tag2      |

    #{content}
    """)
  end

  defp prepare_dirs() do 
    File.mkdir("#{@test_dir}")
    File.mkdir("#{@test_dir}/category1")
  end

  defp clean() do 
    File.rm_rf(@test_dir)
  end
  

end
