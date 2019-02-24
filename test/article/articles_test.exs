defmodule ArticlesTest do
    
    use ExUnit.Case

    test "empty string in list" do
        assert Articles.to_articles([""]) == []
    end

    test "article without category works" do 
        assert Enum.count(Articles.to_articles(["2018-10-12 10:22|this-is-an-article.md"])) == 1
    end

    test "path to article without category" do
        a = Articles.to_article("2018-10-12 10:22|this-is-an-article.md")
        assert a.date == "2018-10-12 10:22"
        assert Article.slug(a) == "this-is-an-article"
        assert Article.category_slug(a) == ""
    end

    test "path with category" do 
        a = Articles.to_article("category/2018-10-12 10:22|this-is-an-article.md")
        assert a.date == "2018-10-12 10:22"
        assert Article.category_slug(a) == "category"
    end

    test "path with more path parts before category" do 
        a = Articles.to_article("/test/123/category/2018-10-12 10:22|this-is-an-article.md")
        assert a.date == "2018-10-12 10:22"
        assert Article.category_slug(a) == "category"
    end
end