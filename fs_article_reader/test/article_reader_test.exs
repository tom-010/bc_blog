defmodule ArticleReaderTest do 
    use ExUnit.Case 

    test "file-reading converts content correctly" do
        assert ArticleReader.path_to_file("test/res/category1/article1.md", "test/res/") == 
        %ArticleFile{
            id: "article1",
            category: "category1",
            path: "test/res/category1/article1.md",
            content: "Content1"
        }
        
    end

    test "file-reading reads all files it should read" do 
        assert ArticleReader.read("test/res") |> Enum.count == 3
    end

    test "path to id handles raw string" do 
        assert ArticleReader.path_to_id("") == ""
        assert ArticleReader.path_to_id("simple_string") == "simple_string"
    end

    test "path to id handles suffix" do 
        assert ArticleReader.path_to_id("string.md") == "string"
        assert ArticleReader.path_to_id("string.abc.md") == "string.abc"
        assert ArticleReader.path_to_id("string.abc") == "string.abc"
    end

    test "path to id handles path before file" do 
        assert ArticleReader.path_to_id("c/string") == "string"
        assert ArticleReader.path_to_id("a/b/c/string") == "string"
    end

    test "path to category empty case" do 
        assert ArticleReader.path_to_category("", "") == ""    
    end

    test "path to category with filled name" do 
        assert ArticleReader.path_to_category("string", "") == ""
    end

    test "root path is only thing beside name, no category" do 
        assert ArticleReader.path_to_category("a/string", "a/") == ""
    end

    test "no rootpath, but category before id: category filled" do 
        assert ArticleReader.path_to_category("category/string", "") == "category"
        assert ArticleReader.path_to_category("a/b/c/string", "") == "a/b/c"
    end

    test "rootpath category and id" do 
        assert ArticleReader.path_to_category("a/b/c/id", "a/b/") == "c"
    end

end