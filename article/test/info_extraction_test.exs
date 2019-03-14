defmodule InfoExtraction do 
    use ExUnit.Case

    test "no info in empty content" do 
        assert uut("") == %{}
    end

    test "no info box given, info not filled" do 
        assert uut("some content without info box") == %{}
    end

    test "content includes info, but no info box" do 
        assert uut("|info, but no box here") == %{}
    end

    test "content contains empty info box, info still empty" do 
        content = """
        |info|    |
        |----|----|
        """
        assert uut(content) == %{}
    end

    test "info-box given with one key, which works" do 
        content = """
        |info|    |
        |----|----|
        |key1|val1|
        """
        assert uut(content) == %{"key1" => "val1"}
    end

    defp uut(input) do 
        Article.extract_info(input)
    end

    test "info cut out of content with empty content flags it" do 
        assert Article.extract_info("") == %{}
    end

    test "info cuts returs everything, if info is whole content" do 
        assert Article.extract_info("""
        |info|    |
        |----|----|
        |key1|val1|
        """) 
        == %{"key1" => "val1"}
    end

    test "info extraction does not get confused by other content" do 
        assert Article.extract_info("""
        |info|    |
        |----|----|
        |key1|val1|
        some content after 
        that is here for removal
        """) 
        == %{"key1" => "val1"}
    end

    test "info extraction ignores additional tables" do 
        assert Article.extract_info("""
            |info|    |
            |----|----|
            |key1|val1|
            some content after 
            that is here for removal
            |another|table  |
            |-------|-------|
            |some   |content|
            """) 
            == %{"key1" => "val1"}
    end

    test "only one info-box gets extracted" do 
        assert Article.extract_info("""
            |info|    |
            |----|----|
            |key1|val1|
            some content after 
            that is here for removal
            |info|    |
            |----|----|
            |key2|val2|
            """) 
            == %{"key1" => "val1"}
    end

    test "cut_out_info does no harm to simple string" do 
        assert Article.cut_out_info("") == ""
        assert Article.cut_out_info("simple string") == "simple string"
    end

    test "info is only content -> cut_out_info returns empty string" do 
        assert Article.cut_out_info("|info|    |\n|----|----|\n|key1|val1|\n") 
               == ""
    end

    test "lines expect info lines are kept, info-box is removed" do 
            assert Article.cut_out_info("""
            title
            =====

            |info|    |
            |----|----|
            |key1|val1|
            some content after 
            that is here for removal
            |table|    |
            |-----|----|
            |key2|val2|
            """) == """
            title
            =====

            some content after 
            that is here for removal
            |table|    |
            |-----|----|
            |key2|val2|
            """
    end

    test "cut out of info box does not affect other tables" do 
        # |----|----| occurs in info-table AND normal table
        # don't just replace all of them when cutting out info-table
        assert Article.cut_out_info("""
            title
            =====

            |info|    |
            |----|----|
            |key1|val1|
            some content after 
            that is here for removal
            |table|    |
            |----|----|
            |key2|val2|
            """) == """
            title
            =====

            some content after 
            that is here for removal
            |table|    |
            |----|----|
            |key2|val2|
            """
    end

    test "two info-tables: second is not cut out, but ignored" do 
        assert Article.cut_out_info("""
            title
            =====

            |info|    |
            |----|----|
            |key1|val1|
            some content after 
            that is here for removal
            |info|    |
            |----|----|
            |key2|val2|
            """) == """
            title
            =====

            some content after 
            that is here for removal
            |info|    |
            |----|----|
            |key2|val2|
            """
    end



    test "info-table extraction, when info table is in first line" do 
        assert Article.extract_info("""
            |info|    |
            |----|----|
            |key1|val1|
            some content after 
            that is here for removal
            |info|    |
            |----|----|
            |key2|val2|
            """) 
            == %{"key1" => "val1"}
    end

    test "info-table extraction: multiple key-val pairs" do 
        assert Article.extract_info("""
        |info|    |
        |----|----|
        |key1|val1|
        |key2|val2|
        |key3|val3|
        some content after 
        that is here for removal
        |info|    |
        |----|----|
        |key2|val2|
        """) 
            == %{"key1" => "val1", "key2" => "val2", "key3" => "val3"}
    end 

    test "info-table extraction: same key multiple times. Last occurence overwrites" do 
        assert Article.extract_info("""
        |info|    |
        |----|----|
        |key1|val1|
        |key1|val2|
        |key1|val3|
        some content after 
        that is here for removal
        |info|    |
        |----|----|
        |key2|val2|
        """) 
            == %{"key1" => "val3"}
    end

    test "info-table extraction: info-table at first and last line" do 
        assert Article.extract_info("""
        |info|    |
        |----|----|
        |key1|val1|
        """) 
            == %{"key1" => "val1"}
    end

    test "info-table cut-out: table in first and last line" do 
        assert Article.cut_out_info("""
        |info|    |
        |----|----|
        |key1|val1|
        """) 
            == ""
    end

    test "keys and values are trimmed" do 
        # note the spaces in the info table
        assert Article.extract_info("""
        |info  |                |
        |------|----------------|
        |   key1|   val 1! |
        |key  2  |  val  2    |
        """) == %{"key1" => "val 1!", "key  2" => "val  2"}
    end
end