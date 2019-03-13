defmodule SlugTest do
 
    use ExUnit.Case

    test "empty slug" do
        assert Slug.slug(nil) == ""
        assert Slug.slug("") == ""
    end

    test "identity slug" do 
        assert Slug.slug("tom") == "tom"
        assert Slug.slug("tom-deniffel") == "tom-deniffel"
    end

    test "slug lowercases" do 
        assert Slug.slug("Tom")  == "tom"
        assert Slug.slug("TOM")  == "tom"
    end

    test "numbers are not deleted" do 
        assert Slug.slug("T0m") == "t0m"
    end

    test "no two minus in a row" do 
        assert Slug.slug("test - 0") == "test-0"
    end

    test "white-spaces are replaced by minus" do
        assert Slug.slug("tom deniffel") == "tom-deniffel"
        assert Slug.slug("tom  deniffel") == "tom-deniffel"
        assert Slug.slug("tom     deniffel") == "tom-deniffel"
    end

    test "special characters are replaced by underscore" do
        assert Slug.slug("tom/deniffel") == "tom_deniffel"
        assert Slug.slug("tom^deniffel") == "tom_deniffel"
        assert Slug.slug("tom$deniffel") == "tom_deniffel"
        assert Slug.slug("tom-deniffel") == "tom-deniffel"
        assert Slug.slug("tom\ndeniffel") == "tom_deniffel"
        assert Slug.slug("tom\tdeniffel") == "tom_deniffel"
    end
end