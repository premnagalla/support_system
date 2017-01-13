class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :check_user_access, only: [:show, :edit, :update, :destroy]

  def index
    @requests = current_user.accessible_requests
  end

  def show
  end

  def new
    @request = Request.new
  end

  def edit
  end

  def create
    @request = Request.new(request_params)
    @request.fix_updated_by(current_user.id)
    @request.save
    set_flash(@request, false)
  end

  def update
    @request.fix_updated_by(current_user.id)
    @request.update(request_params)
    set_flash(@request, false)
  end

  def destroy
    @request.destroy
    set_flash(@request, true)
  end

  private

  # Check access and redirect users who do not have previleges
  def check_user_access
    check_access_and_redirect(@request)
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :description, :status, :unique_id, :department_id, :requested_by,
      :updated_by)
  end
end
