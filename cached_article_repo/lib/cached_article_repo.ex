defmodule CachedArticleRepo do

  @blog_post_default "." 

  def get_articles() do
    CachedArticleRepo.Cache.get()
  end

  def start_link do
    CachedArticleRepo.Cache.start_link()
  end

  def refresh() do 
    read_articles() |> set_articles()
  end

  def clear() do 
    set_articles([])
  end

  defp read_articles() do 
    with_default(System.get_env("ARTICLE_PATH"), @blog_post_default)
    |> ArticleReader.read()
    |> Enum.map(&Article.from_article_file/1)
    |> Enum.map(&HtmlArticle.from_article/1)
  end

  defp set_articles(articles) do
    CachedArticleRepo.Cache.put(articles)
  end

  defp with_default(nil, default) do 
    default
  end

  defp with_default(str, _default) do 
    str
  end
end
