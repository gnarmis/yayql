require 'spec_helper'
require 'lib/yayql/sql_queries_parser.rb'

describe "dumb example" do
  it "is alive" do
    SqlQueries.parse(' ').must_equal(' ')
  end
end
