module ApiHelper
  def json(data)
    JSON.parse(data, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :request
end
