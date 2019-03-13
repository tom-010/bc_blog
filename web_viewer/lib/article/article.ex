defmodule Article do

    defstruct name: "", date: "", category: "", slug: "", content: ""

    def create(article) do
        path = article.path
        parts = path |> String.split("/")
        file_name = parts |> List.last

        category =  if Enum.count(parts) > 1 do 
                        parts |> Enum.at(Enum.count(parts) - 2) 
                    end
        
        the_name = fetch_name(article)
        date = String.slice(file_name, 0, 16)

        content = get_content(article)

        %Article{
            date: date, 
            name: the_name, 
            category: category, 
            slug: slug(the_name),
            content: content,
        }
    end

    def html(article) do 
        MarkdownHtmlConverter.convert(article.content)
    end

    defp get_content(%{content: content}) do 
        lines = content |> String.split("\n")
        c = lines |> Enum.count 

        lines
        |> Enum.slice(2..c)
        |> Enum.join("\n")
    end

    defp get_content(_article_data) do # no content-key
        ""
    end

    def slug(nil) do 
        ""
    end

    def slug(%Article{name: name}) do
        slug(name)
    end

    def slug(name) do
        name 
        |> String.downcase
        |> replace_all("  ", " ")
        |> String.replace(" ", "-")
        |> replace_all("--", "-")
        |> remove_specials
    end

    def category_slug(%Article{category: category}) do 
        slug(category)
    end

    defp replace_all(string, needle, replace) do
        if String.contains?(string, needle) do
            string
            |> String.replace(needle, replace)
            |> replace_all(needle, replace)
        else 
            string
        end
    end

    defp remove_specials(string) do
        string 
        |> String.codepoints 
        |> Enum.map(fn c -> if char_allowed(c) do c else "_" end  end) 
        |> List.to_string
    end

    defp char_allowed(c) do
        (c >= "a" and c <= "z") or (c == "-") or (c >= "0" and c <= "9")
    end

    defp fetch_name(article) do 
        path = article.path
        parts = path |> String.split("/")
        name = parts |> List.last
        l = String.length(name)
        slug = String.slice(name, 17, l-(16+4))        
        
        if Map.has_key?(article, :content) do 
            article.content
            |> String.split("\n")
            |> List.first
        else 
            slug
        end
    end
end 