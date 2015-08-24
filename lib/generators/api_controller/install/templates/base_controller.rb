class API::BaseController < ApplicationController
  protected
  def send_success(data, status=200)
    render json: data, status: status
  end

  def send_errors(errors, status=422)
    render json: errors, status: status
  end

  def send_no_content(status=204)
    head status
  end

  def send_not_found
    head 404, "content_type" => 'text/plain'
  end

  def default_serializer_options
    {root: false}
  end
end
