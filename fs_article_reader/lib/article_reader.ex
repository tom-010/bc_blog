defmodule ArticleReader do 

    def read(path) do 
        list_file_recursivly(path)
        |> Enum.sort()
        |> Enum.filter(& String.ends_with?(&1, ".md"))
        |> Enum.map(& path_to_file(&1, path))
    end

    def path_to_file(path) do 
        path_to_file(path, "")
    end

    def path_to_file(path, root) do  
        %ArticleFile{
            id: path_to_id(path),
            category: path_to_category(path, root),
            path: path,
            content: File.read!(path)
        }
    end

    def path_to_id(path) do 
        path
        |> Path.basename
        |> String.replace_suffix(".md", "")
    end

    defp list_file_recursivly(path \\ ".") do
        cond do
            File.regular?(path) -> [path]
            File.dir?(path) ->
            File.ls!(path)
            |> Enum.map(&Path.join(path, &1))
            |> Enum.map(&list_file_recursivly/1)
            |> Enum.concat
            true -> []
        end
    end

    def path_to_category(path, root) do 
        path
        |> String.replace(root, "")
        |> Path.dirname()
        |> (fn category -> if category == "." do "" else category end end).()
    end

end