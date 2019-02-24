defmodule Article do

    defstruct name: "", date: "", category: "", slug: ""

    def slug(%Article{name: name}) do
        slug(name)
    end

    def slug(name) do
        if name == nil do
            ""
        else 
            name 
            |> String.downcase
            |> replace_all("  ", " ")
            |> String.replace(" ", "-")
            |> remove_specials
        end
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
        (c >= "a" and c <= "z") or 
        c == "-"
    end

    def create(article) do
        path = article.path
        parts = path |> String.split("/")
        name = parts |> List.last

        category =  if Enum.count(parts) > 1 do 
                        parts |> Enum.at(Enum.count(parts) - 2) 
                    end
        
        the_name = fetch_name(article)
        date = String.slice(name, 0, 16)
        %Article{date: date, name: the_name, category: category, slug: Article.slug(the_name)}
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