class EducationalMessagesController < ApplicationController
  before_action :set_educational_message, only: %i[ show edit update destroy ]

  # GET /educational_messages or /educational_messages.json
  def index
    @educational_messages = EducationalMessage.all
  end

  # GET /educational_messages/1 or /educational_messages/1.json
  def show
  end

  # GET /educational_messages/new
  def new
    @educational_message = EducationalMessage.new
  end

  # GET /educational_messages/1/edit
  def edit
  end

  # POST /educational_messages or /educational_messages.json
  def create
    @educational_message = EducationalMessage.new(educational_message_params)
    @educational_message.medic_id = current_medic.id

    respond_to do |format|
      if @educational_message.save
        format.html { redirect_to educational_messages_url, notice: "Educational message was to the parents." }
        format.json { render :show, status: :created, location: @educational_message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @educational_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /educational_messages/1 or /educational_messages/1.json
  def update
    respond_to do |format|
      if @educational_message.update(educational_message_params)
        format.html { redirect_to educational_message_url(@educational_message), notice: "Educational message was successfully updated." }
        format.json { render :show, status: :ok, location: @educational_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @educational_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /educational_messages/1 or /educational_messages/1.json
  def destroy
    @educational_message.destroy!

    respond_to do |format|
      format.html { redirect_to educational_messages_url, notice: "Educational message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_educational_message
      @educational_message = EducationalMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def educational_message_params
      params.require(:educational_message).permit(:title, :content, :category, :duration, :medic_id)
    end
end
