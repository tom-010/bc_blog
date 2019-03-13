defmodule Slug do 
    def slug(nil) do 
        ""
    end
  
    def slug(%{title: title}) do
        slug(title)
    end
  
    def slug(title) do
        title 
        |> String.downcase
        |> replace_all("  ", " ")
        |> String.replace(" ", "-")
        |> replace_all("--", "-")
        |> remove_specials
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
end