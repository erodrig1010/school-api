class CoursesController < ApplicationController
    before_action :set_school
    before_action :set_school_course, only: [:show, :update, :destroy]

    # GET /schools/:school_id/courses
    def index
      json_response(@school.courses)
    end

    # GET /schools/:school_id/courses/:id
    def show
      json_response(@course)
    end

    # POST /schools/:school_id/courses
    def create
      @school.courses.create!(course_params)
      json_response(@school, :created)
    end

    # PUT /schools/:school_id/courses/:id
    def update
      @course.update(course_params)
      head :no_content
    end

    # DELETE /schools/:school_id/courses/:id
    def destroy
      @course.destroy
      head :no_content
    end

    private

    def course_params
      params.permit(:name, :description, :url, :course_type, :commitment, :hours_per_week, :start_date, :class_size, :duration_in_weeks)
    end

    def set_school
      @school = School.find(params[:school_id])
    end

    def set_school_course
      @course = @school.courses.find_by!(id: params[:id]) if @school
    end
end
