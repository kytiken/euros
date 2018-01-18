defmodule Euros.CoreTest do
  use ExUnit.Case, async: true

  describe "Euros.Core.crawl/4" do
    test "every page" do
      url = "https://euros-test.blogspot.jp/"

      assert Euros.Core.crawl(url, fn page ->
               assert 200 === page.status_code
             end) == :ok
    end

    test "with option" do
      url = "https://euros-test.blogspot.jp/"
      http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
      option = %Euros.CrawlOption{http_option: http_option}

      assert Euros.Core.crawl(
               url,
               fn page ->
                 assert 200 === page.status_code
               end,
               option
             ) == :ok
    end

    test "with option and url pattern" do
      url = "https://euros-test.blogspot.jp/"
      http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
      pattern = ~r/test1/
      option = %Euros.CrawlOption{http_option: http_option, pattern: pattern}

      assert Euros.Core.crawl(
               url,
               fn page ->
                 assert 200 === page.status_code
               end,
               option
             ) == :ok
    end

    test "with option depth_limit is nil" do
      url = "https://euros-test.blogspot.jp/2018/01/"
      option = %Euros.CrawlOption{depth_limit: nil}

      assert Euros.Core.crawl(
               url,
               fn page ->
                 assert 200 === page.status_code

                 assert Enum.member?(
                          [
                            "https://euros-test.blogspot.jp/",
                            "https://euros-test.blogspot.jp/2017/12/",
                            "https://euros-test.blogspot.jp/2018/01/",
                            "https://euros-test.blogspot.jp/2017/12/image-page-test.html",
                            "https://euros-test.blogspot.jp/2017/12/test1.html",
                            "https://euros-test.blogspot.jp/2017/12/other-host-link-test.html",
                            "https://euros-test.blogspot.jp/2018/01/january.html",
                            "https://euros-test.blogspot.jp/search?updated-max=2018-01-06T17:17:00%2B09:00&max-results=7"
                          ],
                          page.request_url
                        ),
                        page.request_url
               end,
               option
             ) == :ok
    end

    test "with option depth_limit is 0" do
      url = "https://euros-test.blogspot.jp/2018/01/"
      option = %Euros.CrawlOption{depth_limit: 0}

      assert Euros.Core.crawl(
               url,
               fn page ->
                 assert 200 === page.status_code

                 assert Enum.member?(
                          ["https://euros-test.blogspot.jp/2018/01/"],
                          page.request_url
                        ),
                        page.request_url
               end,
               option
             ) == :ok
    end

    test "with option depth_limit is 1" do
      url = "https://euros-test.blogspot.jp/2018/01/"
      option = %Euros.CrawlOption{depth_limit: 1}

      assert Euros.Core.crawl(
               url,
               fn page ->
                 assert 200 === page.status_code

                 assert Enum.member?(
                          [
                            "https://euros-test.blogspot.jp/",
                            "https://euros-test.blogspot.jp/2017/12/",
                            "https://euros-test.blogspot.jp/2018/01/",
                            "https://euros-test.blogspot.jp/2017/12/image-page-test.html",
                            "https://euros-test.blogspot.jp/2017/12/test1.html",
                            "https://euros-test.blogspot.jp/2017/12/other-host-link-test.html",
                            "https://euros-test.blogspot.jp/2018/01/january.html",
                            "https://euros-test.blogspot.jp/search?updated-max=2018-01-06T17:17:00%2B09:00&max-results=7"
                          ],
                          page.request_url
                        ),
                        page.request_url
               end,
               option
             ) == :ok
    end
  end
end
