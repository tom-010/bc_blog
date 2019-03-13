defmodule FromArticleFile do
  use ExUnit.Case
  
  use ExUnit.Case

    @valid_aricle %{
      id: "id1",
      category: "category1",
      path: "path1",
      content: "title\n=====\nsimple content without markdown or other"
    }

    test "id remains the same" do 
      assert Article.from_article_file(@valid_aricle).id == @valid_aricle.id
    end

    test "category remains the same" do 
      assert Article.from_article_file(@valid_aricle).category == @valid_aricle.category
    end

    test "path remains the same" do 
      assert Article.from_article_file(@valid_aricle).path == @valid_aricle.path
    end

    test "article one line content, first line is title" do
        content = "first line"
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.title == "first line"
    end

    test "article multiple line content, first line is title" do
        content = "first line\nsecond line\n"
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.title == "first line"
    end

    test "article slug is slugged title" do 
        content = "first line\nsecond line\n"
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.slug == "first-line"
    end

    test "article-file has contet, article-content is not empty" do 
        content = "first line\n====\nThird-line"
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.content != ""
    end 

    test "article-file contains only header, content is empty" do 
        content = "first line\n===="
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.content == ""
    end
    
    test "content: first two lines are cut away, as they are the title" do
        content = "first line\n====\nthird line"
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.content == "third line" 
    end

    test "content: info-box is cutted away" do 
      content = """
        title
        =====
        |info|    |
        |----|----|
        |key1|val1|
        content
        """
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.content == "content" 
    end

    test "meta-info gets extracted out of info-box and saved" do 
      content = """
        title
        =====
        |info|    |
        |----|----|
        |key1|val1|
        |key2|val2|
        |key3|val3|
        content
        """
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.info == %{
          "key1" => "val1", 
          "key2" => "val2", 
          "key3" => "val3"
        } 
    end

    test "white lines between title and info box are removed in end-content" do 
      content = """
        title
        =====



        |info|    |
        |----|----|
        |key1|val1|
        |key2|val2|
        |key3|val3|



        content
        """
        a = Article.from_article_file(%{@valid_aricle | content: content})
        assert a.content == "content"
    end
 
end
