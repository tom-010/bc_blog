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

    test "put and get returns identity" do 
        CachedArticleRepo.Cache.put("test")
        assert CachedArticleRepo.Cache.get() == "test"
    end

    test "reset clears cache" do 
        CachedArticleRepo.Cache.put("test")
        CachedArticleRepo.Cache.reset()
        assert CachedArticleRepo.Cache.get() == [] 
    end

end