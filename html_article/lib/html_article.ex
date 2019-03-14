defmodule HtmlArticle do

  def from_article(article) do 
    %{article | 
      content: MarkdownHtmlConverter.convert(article.content)}
    |> Map.put(:author, "")
  end
end
