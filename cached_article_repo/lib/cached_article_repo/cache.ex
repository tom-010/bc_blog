defmodule CachedArticleRepo.Cache do
    use GenServer
    
    def start_link() do 
      GenServer.start_link(__MODULE__, [], name: :article_cache)
    end

    def get() do 
      GenServer.call(:article_cache, :get)
    end

    def put(content) do 
      GenServer.cast(:article_cache, {:put, content})
    end

    def reset() do 
      put([])
    end
    
    def init(messages) do
      {:ok, messages}
    end

    def handle_cast({:put, content}, _articles) do
      {:noreply, content}
    end

    def handle_call(:get, _from, messages) do
      {:reply, messages, messages}
    end
end