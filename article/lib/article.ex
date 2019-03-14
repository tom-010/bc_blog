defmodule Article do

  def from_article_file(article_file) do 
    %{
        id:       article_file.id,
        title:    extract_title(article_file), 
        slug:     Slug.slug(extract_title(article_file)),
        path:     article_file.path,
        category: article_file.category,
        content:  extract_content(article_file) |> cut_out_info() |> String.trim(),
        info:     extract_content(article_file) |> extract_info()
    }
  end

  def extract_info(content) do 
    content
    |> get_info_lines() 
    |> Enum.filter(& not String.starts_with?(&1, "|---") and not String.starts_with?(&1, "|info"))
    |> Enum.map(fn line -> 
        l = String.split(line, "|")
        {Enum.at(l, 1) |> String.trim, Enum.at(l, 2) |> String.trim}
      end) 
    |> Map.new
  end

  def cut_out_info(string) do 
    info_lines = string |> get_info_lines() |> Enum.map(& "#{&1}\n")
    string |> remove_items_in_string(info_lines)
  end

  #######

  defp remove_items_in_string(string, [r|items]) do 
    remove_items_in_string(string |> String.replace(r, "", global: false), items)
  end

  defp remove_items_in_string(string, []) do 
    string
  end

  defp get_info_lines(string) do
    string
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> filter_info
    |> Enum.filter(& &1 != "")
  end

  defp filter_info(lines) do 
    filter_info(lines, :start, [])
  end

  defp filter_info([line|lines], :start, acc) do 
    if line |> String.replace(" ", "") |> String.starts_with?("|info") do 
      filter_info(lines, :collect, acc ++ [line])
    else
      filter_info(lines, :start, acc)
    end
  end

  defp filter_info([line|lines], :collect, acc) do 
    if line |> String.replace(" ", "") |> String.starts_with?("|") do 
      filter_info(lines, :collect, acc ++ [line])
    else
      acc
    end
  end

  defp filter_info(_, _, _) do 
    []
  end


  defp extract_content(%{content: content}) do 
      lines = content |> String.split("\n")
      line_count = lines |> Enum.count 

      lines
      |> Enum.slice(2..line_count)
      |> Enum.join("\n")
  end

  defp extract_content(_) do # no content-key
      ""
  end

  defp extract_title(%{content: content}) do 
    content
        |> String.split("\n")
        |> List.first
  end

  defp extract_title(article) do 
    article.path |> Path.basename()   
  end

end
