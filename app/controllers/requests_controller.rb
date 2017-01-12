class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :check_user_access, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = current_user.department_requests
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    @request.save
    set_flash(@request, false)
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    @request.update(request_params)
    set_flash(@request, false)
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    set_flash(@request, true)
  end

  private

  # Check access and redirect users who do not have previleges
  def check_user_access
    return true if current_user.can_access?(@request)
    redirect_to requests_path, alert: 'You do not have previleges to perform this Action!'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:title, :description, :status, :unique_id, :department_id, :requested_by,
      :updated_by)
  end
end
