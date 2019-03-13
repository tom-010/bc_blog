defmodule ArticlesTest do
    
    use ExUnit.Case

    test "empty string in list" do
        assert Articles.to_articles([%{ path: "" }]) == []
    end

    test "article without category works" do 
        assert Enum.count(Articles.to_articles([%{ path: "2018-10-12 10:22|this-is-an-article.md" }])) == 1
    end

    test "path to article without category" do
        a = Article.create(%{ path: "2018-10-12 10:22|this-is-an-article.md" })
        assert a.date == "2018-10-12 10:22"
        assert Article.slug(a) == "this-is-an-article"
        assert Article.category_slug(a) == ""
    end

    test "path with category" do 
        a = Article.create(%{ path: "category/2018-10-12 10:22|this-is-an-article.md" })
        assert a.date == "2018-10-12 10:22"
        assert Article.category_slug(a) == "category"
    end

    test "path with more path parts before category" do 
        a = Article.create(%{ path: "/test/123/category/2018-10-12 10:22|this-is-an-article.md" })
        assert a.date == "2018-10-12 10:22"
        assert Article.category_slug(a) == "category"
    end

    test "non-markdown-files are not listed" do 
        a = %{ path: "category/2018-10-12 10:22|this-is-an-article.pdf" }
        assert Articles.to_articles([a]) == []
    end

end