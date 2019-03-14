defmodule HtmlArticle do

  def from_article(article) do 
    %{article | 
      content: "<p>content</p>"
    }
  end
end
