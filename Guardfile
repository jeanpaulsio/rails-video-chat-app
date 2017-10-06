guard :minitest, spring: 'bin/rails test', all_on_start: false do
  watch(%r{^test/(.*)/?(.*)_test\.rb$})
  watch('test/test_helper.rb') { 'test' }
  watch('config/routes.rb')    { integration_tests }
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    "test/models/#{matches[1]}_test.rb"
  end

  # Watches views/rooms and runs integration tests
  watch(%r{app/views/rooms/*}) do
    integration_tests
  end

  # Watches views/rooms and runs integration tests
  watch(%r{app/controllers/rooms_controller/*}) do
    integration_tests
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
