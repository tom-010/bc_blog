defmodule Articles do 

    def to_articles(article) do
        article 
        |> Enum.filter(fn a -> a.path != "" end)
        |> Enum.filter(fn a -> String.ends_with?(a.path, ".md") end)
        |> Enum.map(&Article.create(&1))
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