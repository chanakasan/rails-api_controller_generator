class Api::BaseController < ApplicationController
  protected
  def send_success(data, status=200, options={})
    obj = {json: data, status: status}
    obj = obj.merge options
    render obj
  end

  def send_error(data, status=422)
    logger.error data.to_json
    render json: data, status: status
  end

  def send_no_content(status=204)
    head status
  end

  def send_not_found(message=nil)
    if message.nil?
      head 404, "content_type" => 'text/plain'
    else
      render json: {message: message}, status: 404
    end
  end

  def send_forbidden(message=nil)
    if message.nil?
      head 403, "content_type" => 'text/plain'
    else
      render json: {message: message}, status: 403
    end
  end

  def send_validation_errors(errors, message="Validation failed")
    if errors.is_a? ActiveModel::Errors
      all_error_objects = []
      errors.keys.each do |field|
        err_obj = {}
        err_obj[:field] = field
        err_obj[:message] = errors[field].join(", ")
        all_error_objects << err_obj
      end
    else
      all_error_objects = errors
    end

    logger.error all_error_objects.to_json

    render json: {message: message, errors: all_error_objects}, status: 422
  end

  def default_serializer_options
    {root: false}
  end
end
