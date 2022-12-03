class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  private

  def not_found
    head :bad_request
  end

  def not_destroyed
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end
end
