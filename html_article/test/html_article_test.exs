defmodule HtmlArticleTest do
  use ExUnit.Case
  doctest HtmlArticle

  @valid_article  %{
        id:       "id",
        title:    "title",
        slug:     "slug",
        path:     "path",
        category: "category",
        content:  "content",
        info:     %{}
    }
  
  test "create from article uses id, title, category and slug" do 
    assert HtmlArticle.from_article(@valid_article).id == "id"
    assert HtmlArticle.from_article(@valid_article).title == "title"
    assert HtmlArticle.from_article(@valid_article).slug == "slug"
    assert HtmlArticle.from_article(@valid_article).category == "category"
  end

  test "html article has html as content, not markdown as the article" do 
    assert HtmlArticle.from_article(@valid_article).content =~ "<p>content</p>"
  end

  test "author is taken from info, if present" do 
    assert HtmlArticle.from_article(%{@valid_article | info: %{}}).author == ""
    assert HtmlArticle.from_article(%{@valid_article | info: %{"author" => "Thomas Deniffel"}}).author == "Thomas Deniffel"
  end

  test "date is taken from info, if present" do 
    assert HtmlArticle.from_article(%{@valid_article | info: %{}}).date == ""
    assert HtmlArticle.from_article(%{@valid_article | info: %{"date" => "date"}}).date == "date"
  end

  test "info is also present in html-article" do 
    info = %{
      "key1" => "val1", 
      "key2" => "val2",
      "key3" => "val3"
    }
    assert HtmlArticle.from_article(%{@valid_article | info: info}).info == info
  end

end
