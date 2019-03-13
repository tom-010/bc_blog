defmodule MarkdownHtmlConverterTest do 

    use ExUnit.Case 

    test "empty markdown is empty html" do 
        assert "" == MarkdownHtmlConverter.convert("")
    end

    test "document without markdown stuff becomes <p>" do 
        assert MarkdownHtmlConverter.convert("string") =~ "<p>string</p>" 
    end

    test "multiline non-markdown document become multiple <p>" do 
        assert MarkdownHtmlConverter.convert("a\n\nb") =~ "<p>a</p>";
        assert MarkdownHtmlConverter.convert("a\n\nb") =~ "<p>b</p>";
    end

    test "headings becomes one lower, as title uses h1" do 
        assert MarkdownHtmlConverter.convert("##### heading") =~ "<h6>heading</h6>"
        assert MarkdownHtmlConverter.convert("#### heading") =~ "<h5>heading</h5>"
        assert MarkdownHtmlConverter.convert("### heading") =~ "<h4>heading</h4>"
        assert MarkdownHtmlConverter.convert("## heading") =~ "<h3>heading</h3>"
        assert MarkdownHtmlConverter.convert("# heading") =~ "<h2>heading</h2>"
    end

    test "heading with ==== becomes h2" do 
        assert MarkdownHtmlConverter.convert("heading\n=======\n") =~ "<h2>heading</h2>"
    end

    test "heading with ---- becomes h3" do 
        assert MarkdownHtmlConverter.convert("heading\n--------\n") =~ "<h3>heading</h3>"
    end

    test "h6 becomes bold p" do 
        assert MarkdownHtmlConverter.convert("###### heading") =~ "<p><b>heading</b></p>"
    end

    test "image works" do 
        assert MarkdownHtmlConverter.convert("![alt-text](image/link.jpg)") =~ "<img";
        assert MarkdownHtmlConverter.convert("![alt-text](image/link.jpg)") =~ "/>";
        assert MarkdownHtmlConverter.convert("![alt-text](image/link.jpg)") =~ "alt-text";
        assert MarkdownHtmlConverter.convert("![alt-text](image/link.jpg)") =~ "image/link.jpg";
    end

    test "code-block" do 
        assert MarkdownHtmlConverter.convert(
            """
            ```
            some code here
            ```
            """) =~ "<pre>"

        assert MarkdownHtmlConverter.convert(
            """
            ```python
            some code here
            ```
            """) =~ "<pre>"
    end

    test "table" do 
        assert MarkdownHtmlConverter.convert(
            """
            | Tables        | Are           | Cool  |
            | ------------- |:-------------:| -----:|
            | col 3 is      | right-aligned | $1600 |
            | col 2 is      | centered      |   $12 |
            | zebra stripes | are neat      |    $1 |
            """) =~ "<table>"
    end

    test "blockquotes" do 
        assert MarkdownHtmlConverter.convert(
            """
            > Blockquotes are very handy in email to emulate reply text.
            > This line is part of the same quote.
            """) =~ "<blockquote>"
    end

    test "inline-code" do 
        assert MarkdownHtmlConverter.convert(
            """
            Inline `code` has `back-ticks around` it.
            """) =~ "<code"
    end

    test "links" do 
        assert MarkdownHtmlConverter.convert("[link-text](https://www.link.com)") =~ "<a"
        assert MarkdownHtmlConverter.convert("[link-text](https://www.link.com)") =~ "link-text"
        assert MarkdownHtmlConverter.convert("[link-text](https://www.link.com)") =~ "https://www.link.com"
    end

end