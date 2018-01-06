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
      http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
      option = %Euros.CrawlOption{http_option: http_option}
      assert Euros.Core.crawl(url, fn(page) ->
        assert 200 === page.status_code
      end, option) == :ok
    end

    test "with option and url pattern" do
      url = "https://euros-test.blogspot.jp/"
      http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
      pattern = ~r/test1/
      option = %Euros.CrawlOption{http_option: http_option, pattern: pattern}
      assert Euros.Core.crawl(url, fn(page) ->
        assert 200 === page.status_code
      end, option) == :ok
    end
  end
end
