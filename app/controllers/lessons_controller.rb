class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_section, only: [:show]

	def new
		@lesson = Lesson.new
	end

	def create
		@lesson = current_section.lessons.create(lesson_params)
		redirect_to instructor_course_path(current_section.course)
	end

	private

	def require_authorized_for_current_section
		if !current_user.enrolled_in?(current_lesson.section.course)
			redirect_to course_path(current_lesson.section.course), alert: "You must be enrolled in this course to view the lesson."
		end
	end

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end

	def lesson_params
		params.require(:lesson).permit(:title, :subtitle, :video)
	end
end
