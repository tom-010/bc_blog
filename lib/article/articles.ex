defmodule Articles do 

    def to_articles(article) do
        article 
        |> Enum.filter(fn a -> a.path != "" end)
        |> Enum.filter(fn a -> String.ends_with?(a.path, ".md") end)
    end

    def to_article(article) do
        path = article.path
        parts = path |> String.split("/")
        name = parts |> List.last

        category =  if Enum.count(parts) > 1 do 
                        parts |> Enum.at(Enum.count(parts) - 2) 
                    end
        
        l = String.length(name)
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