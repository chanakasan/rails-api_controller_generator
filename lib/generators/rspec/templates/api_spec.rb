require 'rails_helper'

RSpec.describe "<%= class_name.pluralize %> API", type: :request do
  before :each do
    host! "example.com"
  end

  xcontext "list" do
    it 'returns the list of all records' do
      create_<%= file_name %>
      get endpoint_url

      result = json(response.body)
      expect(response.status).to eq(200)
      expect(result.count).to eq(1)
      # TODO: assert returned data
      expect(result.first[:attribute_1]).to eq('value_1')
    end

    it "returns an empty array if no records are found" do
      get endpoint_url

      result = json(response.body)
      expect(response.status).to eq(200)
      expect(result).to eq([])
    end
  end

  xcontext "get" do
    it 'returns a record by id' do
      # TODO: persist a record
      <%= file_name %> = create_<%= file_name %>
      get endpoint_url_with_id(<%= file_name %>.id)

      result = json(response.body)
      expect(response.status).to eq(200)
      # TODO: assert returned data
      expect(result[:attribute_1]).to eq('value_1')
    end

    it "returns 404 response if record not found" do
      get endpoint_url_with_id(123)

      expect(response.status).to eq(404)
    end
  end

  xcontext "insert" do
    it "returns 201 response if successful" do
      # TODO: set data for the request
      data = { attribute_1: 'value_1' }
      post endpoint_url, params: { <%= file_name %>: data }

      result = json(response.body)
      expect(response.status).to eq(201)
      expect(result[:id]).to_not be_nil
    end

    it "returns 422 response if failed to create" do
      # TODO: set some invalid data for the request
      data = {attribute_1: ''}
      post endpoint_url, params: { <%= file_name %>: data }

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
      patch endpoint_url_with_id(<%= file_name %>.id), params: { <%= file_name %>: data }

      expect(response.status).to eq(200)
      # TODO: assert updated data
      expect(<%= file_name %>.reload.attribute_1).to eq('updated_value_1')
    end

    it "returns 422 response if failed to update" do
      <%= file_name %> = create_<%= file_name %>
      # TODO: set some invalid data for the request
      data = {attribute_1: ''}
      patch endpoint_url_with_id(<%= file_name %>.id), params: { <%= file_name %>: data }

      expect(response.status).to eq(422)
    end

    it "returns 404 response if record not found" do
      patch endpoint_url_with_id(123), params: { <%= file_name %>: {} }
      expect(response.status).to eq(404)
    end
  end

  xcontext "delete" do
    it "returns 204 response if successful"  do
      <%= file_name %> = create_<%= file_name %>
      delete endpoint_url_with_id(<%= file_name %>.id)

      expect(response.status).to eq(204)
      all_<%= file_name.pluralize %> = <%= class_name %>.all
      expect(all_<%= file_name.pluralize %>.count).to eq(0)
    end

    it "returns 404 response if record not found" do
      delete endpoint_url_with_id(123)
      expect(response.status).to eq(404)
    end
  end

  private
  def create_<%= file_name %>
    raise NotImplementedError
    # TODO:
    # <%= class_name %>.create!(attribute_1: 'value_1')
  end

  def endpoint_url
    "/api/<%= file_name.pluralize %>"
  end

  def endpoint_url_with_id(id)
    "/api/<%= file_name.pluralize %>/#{id}"
  end
end
