guard :minitest, autorun: false, spring: true do
  watch(%r{^app/(.+).rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller.rb$}) do |m|
    "test/integration/#{m[1]}_test.rb"
  end
  watch(%r{^app/views/(.+)_mailer/.+}) do |m|
    "test/mailers/#{m[1]}_mailer_test.rb"
  end
  watch(%r{^lib/(.+).rb$}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test.rb$})
  watch(%r{^test/test_helper.rb$}) { 'test' }
end
