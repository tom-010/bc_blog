defmodule MarkdownHtmlConverter do
    
    def convert(markdown) do
        Earmark.as_html!(markdown)
        |> String.replace("<h6>", "<p><b>") |> String.replace("</h6>", "</b></p>")
        |> String.replace("h5>", "h6>")
        |> String.replace("h4>", "h5>")
        |> String.replace("h3>", "h4>")
        |> String.replace("h2>", "h3>")
        |> String.replace("h1>", "h2>")
    end
end