defmodule CachedArticleRepo do
  use GenServer

  def get_articles() do
    GenServer.call(:article_cache, :get_messages)
  end

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :article_cache)
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
    GenServer.cast(:article_cache, {:add_message, articles})
  end

  defp with_default(nil, default) do 
    default
  end

  defp with_default(str, _default) do 
    str
  end

  # SERVER

  def init(messages) do
    {:ok, messages}
  end

  def handle_cast({:add_message, new_articles}, _articles) do
    {:noreply, new_articles}
  end

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end
end

# defmodule CachedArticleRepo do
#   use GenServer

#   @blog_post_default "../blog_post_res"

#   def start_link() do
#     GenServer.start_link(__MODULE__, name: :article_cache)
#     # refresh()
#   end

#   def refresh() do
#     GenServer.call(:article_cache, {:set, "abc"})
#   end

#   def get_articles() do
#     {:reply, articles} = GenServer.call(:article_cache, :get)
#     articles

#   end


#   defp read_articles() do 
#     with_default(System.get_env("ARTICLE_PATH"), @blog_post_default)
#     |> ArticleReader.read()
#     |> Enum.map(&Article.from_article_file/1)
#     |> Enum.map(&HtmlArticle.from_article/1)
#   end

#   defp with_default(nil, default) do 
#     default
#   end

#   defp with_default(str, default) do 
#     str
#   end

#   @impl true
#   def init(stack) do
#     {:ok, stack}
#   end

#   @impl true
#   def handle_call(:get, _from, articles) do
#     {:reply, articles}
#   end

#   @impl true
#   def handle_cast({:set, articles}, state) do
#     {:noreply, articles}
#   end


# end
