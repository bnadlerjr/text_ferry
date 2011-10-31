require "sequel"

module TextFerry
  class Loader
    def initialize(database_uri)
      @db = Sequel.connect(database_uri)
    end

    def load_table(table_name, &schema)
      @db.create_table!(table_name, &schema)
    end
  end
end
