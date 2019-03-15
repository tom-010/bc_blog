defmodule CachedArticleRepo.CacheTest do
    use ExUnit.Case 

    setup do
        CachedArticleRepo.Cache.start_link()
        on_exit fn -> CachedArticleRepo.Cache.reset() end
        :ok 
    end

    test "cache returns empty list initally" do 
        assert CachedArticleRepo.Cache.get() == [] 
    end

end