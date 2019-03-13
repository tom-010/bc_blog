defmodule FsArticleReaderTest do
  use ExUnit.Case
  doctest FsArticleReader

  test "greets the world" do
    assert FsArticleReader.hello() == :world
  end
end
