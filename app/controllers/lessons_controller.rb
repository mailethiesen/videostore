class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment, :only => [:show]

  def show
  end

  private

  def require_enrollment
    course = current_lesson.section.course
    if !(current_lesson.section.course.user.enrolled_in?(course))
      redirect_to course_path(course), alert: 'You must enroll to see the lessons!'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
