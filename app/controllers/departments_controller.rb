class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy ]

  # GET /departments
  def index
    @departments = policy_scope(Department)
  end

  # GET /departments/1
  def show
    authorize @department
  end

  # GET /departments/new
  def new
    @department = Department.new
    authorize @department
  end

  # GET /departments/1/edit
  def edit
    authorize @department
  end

  # POST /departments
  def create
    @department = Department.new(department_params)
    authorize @department

    if @department.save
      redirect_to @department, notice: "Department was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /departments/1
  def update
    authorize @department
    if @department.update(department_params)
      redirect_to @department, notice: "Department was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /departments/1
  def destroy
    authorize @department
    @department.destroy!
    redirect_to departments_path, notice: "Department was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.expect(department: [ :name, :description ])
    end
end
