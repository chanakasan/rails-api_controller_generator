require 'rails_helper'

RSpec.describe "<%= class_name.pluralize %> API", type: :request do
  before :each do
    host! "example.com"
  end

  let(:url) { "/api/<%= file_name.pluralize %>" }

  def url_with_id(id)
    "/api/<%= file_name.pluralize %>/#{id}"
  end

  # TODO: set default required attribute values inside this create fixture method.
  # Or you may remove this method and use a factory girl factory instead.
  def create_<%= file_name %>(attributes={})
    default_attributes = {
      attribute_1: 'default_value',
    }

    <%= class_name %>.create!(default_attributes.merge(attributes))
  end

  def json(data)
    JSON.parse(data, symbolize_names: true)
  end

  xcontext "list" do
    it 'returns the list of all <%= file_name.pluralize %>' do
      create_<%= file_name %>
      get url

      json_data = json(response.body)
      expect(response.status).to eq(200)
      expect(json_data.count).to eq(1)
      # TODO: assert returned data
      expect(json_data.first[:attribute_1]).to eq('default_value')
    end

    it "returns an empty array if no <%= file_name.pluralize %> are found" do
      get url

      json_data = json(response.body)
      expect(response.status).to eq(200)
      expect(json_data).to eq([])
    end
  end

  xcontext "get" do
    it 'returns <%= file_name %> by id' do
      # TODO: create a new fixture
      <%= file_name %> = create_<%= file_name %>(attribute_1: 'value_1')
      get url_with_id(<%= file_name %>.id)

      json_data = json(response.body)
      expect(response.status).to eq(200)
      # TODO: assert returned data
      expect(json_data[:attribute_1]).to eq('value_1')
    end

    it "returns 404 if not found" do
      get url_with_id(123)

      expect(response.status).to eq(404)
    end
  end

  xcontext "insert" do
    it "returns 201 response if successful" do
      # TODO: set data for the request
      data = { attribute_1: 'value_1' }

      post url, <%= file_name %>: data

      result = json(response.body)
      expect(response.status).to eq(201)
      expect(result[:id]).to_not be_nil
    end

    it "returns 422 response if failed to create" do
      # TODO: set some invalid data for the request
      data = {attribute_1: ''}
      post url, <%= file_name %>: data

      result = json(response.body)
      expect(result).to_not be_empty
      expect(response.status).to eq(422)
    end
  end

  xcontext "patch" do
    it "returns 200 response if successful"  do
      <%= file_name %> = create_<%= file_name %>

      # TODO: set updated data for the request
      data = {attribute_1: 'updated_value_1'}
      patch url_with_id(<%= file_name %>.id), <%= file_name %>: data

      expect(response.status).to eq(200)
      # TODO: assert updated data
      expect(<%= file_name %>.reload.attribute_1).to eq('updated_value_1')
    end

    it "returns 422 response if failed to update" do
      <%= file_name %> = create_<%= file_name %>

      # TODO: set some invalid data for the request
      data = {attribute_1: ''}
      patch url_with_id(<%= file_name %>.id), <%= file_name %>: data

      expect(response.status).to eq(422)
    end

    it "returns 404 response if <%= file_name %> does not exist" do
      patch url_with_id(123), <%= file_name %>: {}

      expect(response.status).to eq(404)
    end
  end

  xcontext "delete" do
    it "returns 204 response if successful"  do
      <%= file_name %> = create_<%= file_name %>

      delete url_with_id(<%= file_name %>.id)

      expect(response.status).to eq(204)

      all_<%= file_name.pluralize %> = <%= class_name %>.all
      expect(all_<%= file_name.pluralize %>.count).to eq(0)
    end

    it "returns 404 response if <%= file_name %> does not exist" do
      delete url_with_id(123)

      expect(response.status).to eq(404)
    end
  end
end
