class SchoolsController < ApplicationController
    before_action :set_school, only: [:show, :update, :destroy]

    # GET /schools
    def index
        @schools = School.all
        json_response(@schools)
    end

    # POST /schools
    def create
        @school = current_user.schools.create!(school_params)
        json_response(@school, :created)
    end

    # GET /schools/:id
    def show
        json_response(@school)
    end

    #PUT /schools/:id
    def update
        @school.update(school_params)
        head :no_content
    end

    # DELETE /schools/:id
    def destroy
        @school.destroy
        head :no_content
    end

    private

    def school_params
        params.permit(:name, :source_url, :etag, :about, :website, :email, :job_guarantee, :gi_bill, :job_assistance, :licensing, :housing, :corporate_training, :closed)
    end

    def set_school
        @school = School.find(params[:id])
    end
end
