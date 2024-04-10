class UploadedLogsController < ApplicationController
  before_action :set_uploaded_log, only: %i[show destroy]

  # GET /uploaded_logs or /uploaded_logs.json
  def index
    @uploaded_logs = UploadedLog.all
  end

  # GET /uploaded_logs/1 or /uploaded_logs/1.json
  def show; end

  # GET /uploaded_logs/new
  def new
    @uploaded_log = UploadedLog.new
  end

  # POST /uploaded_logs or /uploaded_logs.json
  def create
    @uploaded_log = UploadedLog.create(uploaded_log_params)

    respond_to do |format|
      format.turbo_stream
    end
  end

  # DELETE /uploaded_logs/1 or /uploaded_logs/1.json
  def destroy
    @uploaded_log.destroy!

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_uploaded_log
    @uploaded_log = UploadedLog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def uploaded_log_params
    params.require(:uploaded_log).permit(:logfile)
  end
end
