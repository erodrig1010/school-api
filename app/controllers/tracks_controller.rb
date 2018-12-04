class TracksController < ApplicationController
  before_action :set_school
  before_action :set_school_track, only: [:show, :update, :destroy]

  # GET /schools/:school_id/tracks
  def index
    json_response(@school.tracks)
  end

  # GET /schools/:school_id/tracks/:id
  def show
    json_response(@track)
  end

  # POST /schools/:school_id/tracks
  def create
    @school.tracks.create!(track_params)
    json_response(@school, :created)
  end

  # PUT /schools/:school_id/tracks/:id
  def update
    @track.update(track_params)
    head :no_content
  end

  # DELETE /schools/:school_id/tracks/:id
  def destroy
    @track.destroy
    head :no_content
  end

  private

  def track_params
    params.permit(:name, :url, :school_id)
  end

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_school_track
    @track = @school.tracks.find_by!(id: params[:id]) if @school
  end
end
