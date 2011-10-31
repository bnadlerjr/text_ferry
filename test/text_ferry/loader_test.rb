require "test_helper"
require "text_ferry"

class LoadTest < Test::Unit::TestCase
  DATA_PATH = File.join(File.dirname(__FILE__), "..", "sample_data")
  DB_FILE   = File.join(DATA_PATH, "sample.db")
  DB        = Sequel.sqlite(DB_FILE)

  setup do
    @loader = TextFerry::Loader.new("sqlite://#{DB_FILE}", DATA_PATH)
  end

  test "create a new loader" do
    assert @loader, "expected to be able to create a new Loader"
  end

  context "table creation" do
    test "creates table if it doesn't exist" do
      load_routes
      assert DB[:routes].all.length
    end

    test "drops table if it already exists" do
      DB.drop_table(:routes) if DB[:routes]
      DB.create_table :routes do
        primary_key :id
      end

      assert_nothing_raised { load_routes }
    end
  end

  context "table data" do
    test "loads all data from csv file" do
      load_routes
      assert_equal 19, DB[:routes].all.length
    end
  end

  private
    def load_routes
      @loader.load_table(:routes) do
        primary_key :route_id
        String :route_long_name
      end
    end
end
