ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.produciton?

require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each do |file|
  require file
end

# Checks for pending migration and applies them before tests are run
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Mix in different behaviours to your tests based on their file location
  config.infer_spec_type_from_file_location!

  # sorcery
  config.include Sorcery::TestHelpers::Internal
  config.include Sorcery::TestHelpers::Rails::Controller, type: :controller
  config.include Sorcery::TestHelpers::Rails::Integration, type: :feature

  # Capybara
  config.include Capybara::DSL

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.include ActionDispatch::TestProcess

  FactoryBot::SyntaxRunner.class_eval do
    include ActionDispatch::TestProcess
  end
end
