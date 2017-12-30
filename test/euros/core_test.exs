defmodule Euros.CoreTest do
  use ExUnit.Case, async: true

  describe "Euros.Core.crawl/4" do
    test "every page" do
      url = "https://euros-test.blogspot.jp/"
      assert Euros.Core.crawl(url, fn(page) ->
        assert 200 === page.status_code
      end) == :ok
    end

    test "with option" do
      url = "https://euros-test.blogspot.jp/"
      option = %Euros.HTTPOption{cookie: "foo=bar;"}
      assert Euros.Core.crawl(url, fn(page) ->
        assert 200 === page.status_code
      end, option) == :ok
    end

    test "with option and url pattern" do
      url = "https://euros-test.blogspot.jp/"
      option = %Euros.HTTPOption{cookie: "foo=bar;"}
      pattern = ~r/test1/
      assert Euros.Core.crawl(url, fn(page) ->
        assert 200 === page.status_code
      end, option, pattern) == :ok
    end
  end
end
