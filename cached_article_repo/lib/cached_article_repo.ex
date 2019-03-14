defmodule CachedArticleRepo do
  
  @blog_post_default "../blog_post_res"

  def get_articles() do 
    with_default(System.get_env("ARTICLE_PATH"), @blog_post_default)
    |> IO.inspect
    |> ArticleReader.read()
    |> Enum.map(&Article.from_article_file/1)
    |> Enum.map(&HtmlArticle.from_article/1)
  end

  defp with_default(nil, default) do 
    default
  end

  defp with_default(str, default) do 
    str
  end


end
