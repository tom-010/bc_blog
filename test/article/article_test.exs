defmodule ArticleTest do
 
    use ExUnit.Case

    test "empty slug" do
        assert Article.slug(nil) == ""
        assert Article.slug("") == ""
    end

    test "identity slug" do 
        assert Article.slug("tom") == "tom"
        assert Article.slug("tom-deniffel") == "tom-deniffel"
    end

    test "slug lowercases" do 
        assert Article.slug("Tom")  == "tom"
    end
end