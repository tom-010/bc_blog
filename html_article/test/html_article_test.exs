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

  test "author is empty, if info is empty" do 
    assert HtmlArticle.from_article(%{@valid_article | info: %{}}).author == ""
  end

end
