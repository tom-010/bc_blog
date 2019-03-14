defmodule HtmlArticle do

  def from_article(article) do 
    %{article | 
      content: MarkdownHtmlConverter.convert(article.content)}
    |> Map.put(:author, get_info_item(article, "author"))
  end

  def get_info_item(article, key) do 
    if Map.has_key?(article, key) do 
      Map.get(article, key) 
    else 
      ""
    end
  end
end
