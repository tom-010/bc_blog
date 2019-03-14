defmodule CachedArticleRepo do
  
  @path_to_posts "../blog_post_res"

  defp get_articles() do 
    @path_to_posts
    |> ArticleReader.read()
    |> Enum.map(&Article.from_article_file/1)
    |> Enum.map(&HtmlArticle.from_article/1)
  end

  
end
