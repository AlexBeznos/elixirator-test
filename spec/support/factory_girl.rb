RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before do
    FactoryGirl.find_definitions if FactoryGirl.factories.count == 0
  end
end
