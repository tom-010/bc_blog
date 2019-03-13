defmodule ArticleReaderTest do 
    use ExUnit.Case 

    test "file-reading" do
        assert ArticleReader.read("test/res") == [
            %{
                path: "test/res/category1/article1.md",
                content: "Content1"
            },
            %{
                path: "test/res/category1/article2.md",
                content: "Content2"
            },
            %{
                path: "test/res/category1/some_file.pdf",
                content: ""
            },
            %{
                path: "test/res/category2/article3.md",
                content: "Content3"
            }
        ]

    end

end