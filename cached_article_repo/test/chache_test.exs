defmodule CachedArticleRepo.CacheTest do
    use ExUnit.Case 

    setup do
        CachedArticleRepo.Cache.start_link()
        
        :ok 
    end

    test "cache returns empty list initally" do 
        assert CachedArticleRepo.Cache.get() == [] 
    end

end