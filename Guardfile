# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :minitest, spring: "bin/rails test", all_on_start: false do
  watch(%r{^test/(.*)/?(.*)_test\.rb$})
  watch('test/test_helper.rb') { 'test' }
  watch('config/routes.rb')    { integration_tests }
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    "test/models/#{matches[1]}_test.rb"
  end

  # Watches views and runs integration tests
  watch(%r{app/views/rooms/*}) do
    resource_tests('rooms')
  end

  # Returns the integration tests corresponding to the given resource.
  def integration_tests(resource = :all)
    if resource == :all
      Dir['test/integration/*']
    else
      Dir["test/integration/#{resource}_*.rb"]
    end
  end

  # Returns the controller tests corresponding to the given resource.
  def controller_test(resource)
    "test/controllers/#{resource}_controller_test.rb"
  end

  # Returns all tests for the given resource.
  def resource_tests(resource)
    integration_tests(resource) << controller_test(resource)
  end
end
