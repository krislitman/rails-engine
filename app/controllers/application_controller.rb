class ApplicationController < ActionController::API
  include ActionController::Helpers

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
  
  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: 404
  end
end
