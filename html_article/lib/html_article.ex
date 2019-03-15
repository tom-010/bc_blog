defmodule HtmlArticle do

  def from_article(article) do 
    %{article | 
      content: MarkdownHtmlConverter.convert(article.content)}
    |> Map.put(:author, get_info_item(article, "author"))
    |> Map.put(:date, get_info_item(article, "date"))
  end

  def get_info_item(article, key) do 
    if Map.has_key?(article.info, key) do 
      Map.get(article.info, key) 
    else 
      ""
    end
  end
end
