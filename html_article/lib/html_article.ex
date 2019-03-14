defmodule HtmlArticle do

  def from_article(article) do 
    r = %{article | 
      content: MarkdownHtmlConverter.convert(article.content)}
    r = Map.put(r, :author, "")
  end
end
