require 'active_record'
require 'sqlite3'

class Engine < ActiveRecord::Base

  def self.setup
    self.establish_connection(
      adapter: 'sqlite3',
      database: '../db/dev.db'
    )
  end

  # we have access to `.connection`

end


def make_sql_statement(file_path)
  expanded_path = File.expand_path(file_path)
  name = File.basename(expanded_path, File.extname(expanded_path))

  define_method name.to_sym do |conn, params|
    conn.execute(File.read(expanded_path), params)
  end
end

