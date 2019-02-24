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
        assert Article.slug("TOM")  == "tom"
    end

    test "white-spaces are replaced by minus" do
        assert Article.slug("tom deniffel") == "tom-deniffel"
        assert Article.slug("tom  deniffel") == "tom-deniffel"
        assert Article.slug("tom     deniffel") == "tom-deniffel"
    end

    test "special characters are replaced by underscore" do
        assert Article.slug("tom/deniffel") == "tom_deniffel"
        assert Article.slug("tom^deniffel") == "tom_deniffel"
        assert Article.slug("tom$deniffel") == "tom_deniffel"
        assert Article.slug("tom-deniffel") == "tom-deniffel"
        assert Article.slug("tom--deniffel") == "tom--deniffel"
        assert Article.slug("tom\ndeniffel") == "tom_deniffel"
        assert Article.slug("tom\tdeniffel") == "tom_deniffel"
    end
end