defmodule CachedArticleRepoTest do
  use ExUnit.Case
  doctest CachedArticleRepo

  test "greets the world" do
    assert CachedArticleRepo.hello() == :world
  end
end
