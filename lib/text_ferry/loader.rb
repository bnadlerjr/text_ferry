require "csv"
require "sequel"

module TextFerry
  # Loads CSV data into a database.
  class Loader
    # database_uri::
    #   A URI that points to a database. See
    #   http://sequel.rubyforge.org/rdoc/classes/Sequel.html#method-c-connect
    #   for more info.
    #
    # data_path::
    #   The full path to a folder that contains one or more CSV files.
    def initialize(database_uri, data_path)
      @db = Sequel.connect(database_uri)
      @data_path = data_path
    end

    # Loads data from a CSV file into the database. Assumes that +table_name+
    # corresponds to a CSV file in +data_path+. Warning: if the table already
    # exists, it will be dropped!
    #
    # table_name::
    #   The name of the CSV file to load; will also be used as the table name
    #   in the database.
    #
    # schema::
    #   A block that specifies the schema of the CSV file / table. See
    #   http://sequel.rubyforge.org/rdoc/files/doc/schema_modification_rdoc.html
    #   for more info.
    def load_table(table_name, &schema)
      @db.create_table!(table_name, &schema)
      load_data(table_name)
    end

    private
      def fields_for(table_name)
        @db.schema(table_name).map { |c| c[0] }
      end

      def load_data(table_name)
        CSV.table(File.join(@data_path, "#{table_name}.csv")).each do |row|
          mapping = fields_for(table_name).map { |f| [f, row[f]] }
          @db[table_name].insert(Hash[mapping])
        end
      end
  end
end
