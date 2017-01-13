class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :check_admin_access

  def index
    @departments = Department.all
  end

  def show
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    @department.save
    set_flash(@department, false)
  end

  def update
    @department.update(department_params)
    set_flash(@department, false)
  end

  def destroy
    @department.destroy
    set_flash(@department, true)
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
  end
end
