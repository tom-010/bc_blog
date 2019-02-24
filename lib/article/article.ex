defmodule Article do

    defstruct name: "", date: "", category: ""

    def slug(%Article{name: name}) do
        slug(name)
    end

    def category_slug(%Article{category: category}) do 
        slug(category)
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
end 