defmodule ArticleReader do 

    def read(path) do 
        ls_r(path)
        |> Enum.sort()
        |> Enum.map(fn a -> %{
            path: a,
            content: if String.ends_with?(a, ".md") do File.read!(a) else "" end
        } end)
    end

    defp ls_r(path \\ ".") do
        cond do
            File.regular?(path) -> [path]
            File.dir?(path) ->
            File.ls!(path)
            |> Enum.map(&Path.join(path, &1))
            |> Enum.map(&ls_r/1)
            |> Enum.concat
            true -> []
        end
    end
end