require 'active_record'
require 'sqlite3'
require 'erb'
require 'tilt'

Tilt.register Tilt::ERBTemplate, 'sql'

class Engine < ActiveRecord::Base

  def self.setup
    self.establish_connection(
      adapter: 'sqlite3',
      database: File.expand_path(File.join(File.dirname(__FILE__), '..', '/db/dev.db'))
    )
  end

  def self.connection
    super
  rescue ActiveRecord::ConnectionNotEstablished => e
    self.setup
    super
  end

end

def name_regex
  /^[a-z_][a-zA-Z_0-9]*$/
end

def make_query(file_path)
  expanded_path = File.expand_path(file_path)
  # file needs to actually exist
  return unless File.exists? expanded_path

  name = File.basename(expanded_path, File.extname(expanded_path))
  # needs to be a valid possible local variable name
  return unless name.underscore =~ name_regex

  define_method name.underscore.to_sym do |conn, **params|

    results = if params.empty?
      conn.execute(sql_str)
    else
      output = Tilt.new(expanded_path).render(nil, **params)
      conn.execute(output)
    end

    {results: results, connection: conn}
  end
end

# Example 1:
# > make_query('queries/get_users.sql')
# > get_users(Engine.connection)

# Example 2:
# > make_query('queries/get_users_2.sql')
# > get_users_2(Engine.connection, {name: "'Dave'")
