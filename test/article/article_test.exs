defmodule ArticleTest do
 
    use ExUnit.Case

    test "article has no content, slug is name" do 
        a = Article.create(%{ path: "2018-10-12 10:22|this-is-an-article.md" })
        assert a.date == "2018-10-12 10:22"
        assert Article.slug(a) == "this-is-an-article"
        assert Article.category_slug(a) == ""
        assert a.name == "this-is-an-article"
    end

    test "article one line content, first line is name" do
        a = Article.create(%{ 
                path: "2018-10-12 10:22|this-is-an-article.md",
                content: "first line"
            })
        assert a.name == "first line"
    end

    test "article multiple line content, first line is name" do
        a = Article.create(%{ 
                path: "2018-10-12 10:22|this-is-an-article.md",
                content: "first line\nsecond line\n"
            })
        assert a.name == "first line"
    end

    test "article slug is slugged name" do 
        a = Article.create(%{ 
            path: "2018-10-12 10:22|this-is-an-article.md",
            content: "first line\nsecond line\n"
        })
        assert a.slug == "first-line"
    end

    test "article-file has contet, article-content is not empty" do 
        a = Article.create(%{
            path: "2018-10-12 10:22|this-is-an-article.md",
            content: "first line\n====\nThird-line"
        })
        assert a.content != ""
    end

    test "article-file contains only header, content is empty" do 
        a = Article.create(%{
            path: "2018-10-12 10:22|this-is-an-article.md",
            content: "first line\n===="
        })
        assert a.content == ""
    end
    
    test "content: first two lines are cut away, as they are the title" do
        a = Article.create(%{
            path: "2018-10-12 10:22|this-is-an-article.md",
            content: "first line\n====\nthird line"
        })
        assert a.content == "third line" 
    end

end