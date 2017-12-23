defmodule Euros.CoreTest do
  use ExUnit.Case, async: true

  describe "Euros.Core.crawl/2" do
    test "every page" do
      url = "https://euros-test.blogspot.jp/"
      assert Euros.Core.crawl(url, fn(page) ->
        assert 200 === page.status_code
      end) == :ok
    end
  end
end
