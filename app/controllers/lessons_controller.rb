class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_lesson, only: [:show]

	def show
	  # current_course = current_lesson.section.course
 		# enrollment = Enrollment.find_by(course: current_course, user: current_user)
 		# if enrollment.nil?
   # 		redirect_to course_path(current_course), alert: "You must be enrolled in this course before you can view the lesson."
 		# end
	end

	private

	def require_authorized_for_current_lesson
		if !current_user.enrolled_in?(current_lesson.section.course)
			redirect_to course_path(current_lesson.section.course), alert: "You must be enrolled in this course to view the lesson."
		end
	end

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end
end
