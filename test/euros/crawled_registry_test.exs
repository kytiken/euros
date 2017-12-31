defmodule Euros.CrawledRegistryTest do
  use ExUnit.Case, async: true

  describe "Euros.CrawledRegistry.start/1" do
    test "0 argument" do
      assert {:ok, registry_name} = Euros.CrawledRegistry.start
      assert "" !== registry_name
    end

    test "1 argument" do
      assert {:ok, registry_name} = Euros.CrawledRegistry.start(:"hello")
      assert :"hello" === registry_name
    end

    test "already started" do
      assert {:ok, _} = Euros.CrawledRegistry.start(:"hello")
      assert {:ok, _} = Euros.CrawledRegistry.start(:"hello")
    end
  end

  describe "Euros.CrawledRegistry.register/2" do
    test "can register" do
      {:ok, registry_name} = Euros.CrawledRegistry.start()
      refute Euros.CrawledRegistry.exists?(registry_name, URI.parse("http://example.com"))
      Euros.CrawledRegistry.register(registry_name, URI.parse("http://example.com"))
      assert Euros.CrawledRegistry.exists?(registry_name, URI.parse("http://example.com"))
    end
  end

  describe "Euros.CrawledRegistry.exists?/2" do
    test "not registerd" do
      {:ok, registry_name} = Euros.CrawledRegistry.start()
      refute Euros.CrawledRegistry.exists?(registry_name, URI.parse("http://example.com"))
    end

    test "already register" do
      {:ok, registry_name} = Euros.CrawledRegistry.start()
      Euros.CrawledRegistry.register(registry_name, URI.parse("http://example.com"))
      assert Euros.CrawledRegistry.exists?(registry_name, URI.parse("http://example.com"))
    end
  end
end
