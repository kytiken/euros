defmodule Euros.HTTPTest do
  use ExUnit.Case, async: true

  test "fetch_pages" do
    assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("http://example.com")
  end
end
