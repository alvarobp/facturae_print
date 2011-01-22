$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'facturae_print'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
end

def fixture(name)
  if @fixtures.nil?
    @fixtures ||= {}
    Dir["#{File.expand_path('../fixtures', __FILE__)}/*"].each do |file|
      pathname = Pathname.new(file)
      @fixtures[pathname.basename.to_s] = pathname.read
    end
  end
  @fixtures[name]
end