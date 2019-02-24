defmodule Articles do 
    def to_articles(paths) do
        paths |> Enum.filter(fn p -> p != "" end)
    end

    def to_article(path) do 4
        parts = path |> String.split("/")
        name = parts |> List.last
        category = if Enum.count(parts) > 1 do parts |> Enum.at(Enum.count(parts) - 2) end
        l = String.length(name)
        slug = String.slice(name, 17, l-(16+4))
        date = String.slice(name, 0, 16)
        %Article{date: date, name: slug, category: category}
    end
end