class EnrollmentsController < ApplicationController
  before_action :set_course
  before_action :set_enroll, only: [:show, :edit, :upate, :destroy]

  def index
    # @enrollments = @course.enrollments
    @teachers = @course.enrollments.where(role: 'teacher')
    @tas = @course.enrollments.where(role: 'ta')
    @students = @course.enrollments.where(role: 'student')
  end

  def new
    @users = User.all - @course.users
    @enrollment = @course.enrollments.new
  end

  def create
    @enrollment = @course.enrollments.new(enrollment_params)
    if @enrollment.save
      redirect_to course_enrollments_path(course)
    else 
      render :new
    end
  end


  def show
  end

  def edit
  end

  def upate
    if @enrollment.update(enrollment_params)
      redirect_to course_enrollments_path(@course)
    else
      render :edit
    end
  end

  def destroy
    @enrollment.save
    redirect_to course_enrollment_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:role, :user_id)
  end

  def set_enroll
    @enrollment = @course.enrollments.find(params[:id])
  end
end