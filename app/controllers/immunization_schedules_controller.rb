class ImmunizationSchedulesController < ApplicationController
  before_action :set_immunization_schedule, only: %i[ show edit update destroy ]

  # GET /immunization_schedules or /immunization_schedules.json
  def index
    if params[:name].present?
      search_term = "%#{params[:name].downcase}%"
      @immunization_schedules = ImmunizationSchedule.joins(:child).where("lower(children.baby_name) LIKE ?", search_term)
    else
      @immunization_schedules = ImmunizationSchedule.all
    end
  end

  # GET /immunization_schedules/1 or /immunization_schedules/1.json
  def show
    @immunization_schedule = ImmunizationSchedule.find(params[:id])
    @child = @immunization_schedule.child 
  end  

  def new
    @child = Child.find(params[:child_id])
    @immunization_schedule = @child.immunization_schedules.build
  end

  def update_status
  @schedule = ImmunizationSchedule.find(params[:id])
  @schedule.update(status: true) 
  flash[:notice] = "Immunization status updated successfully."
  redirect_to @schedule.child 
end

  # GET /immunization_schedules/1/edit
  def edit
  end

  # POST /immunization_schedules or /immunization_schedules.json
  def create
    @immunization_schedule = ImmunizationSchedule.new(immunization_schedule_params)
    @immunization_schedule.medic_id = current_medic.id
    respond_to do |format|
      if @immunization_schedule.save
        format.html { redirect_to immunization_schedule_url(@immunization_schedule), notice: "Immunization schedule was successfully created." }
        format.json { render :show, status: :created, location: @immunization_schedule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @immunization_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /immunization_schedules/1 or /immunization_schedules/1.json
  def update
    respond_to do |format|
      if @immunization_schedule.update(immunization_schedule_params)
        format.html { redirect_to immunization_schedule_url(@immunization_schedule), notice: "Immunization schedule was successfully updated." }
        format.json { render :show, status: :ok, location: @immunization_schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @immunization_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /immunization_schedules/1 or /immunization_schedules/1.json
  def destroy
    @immunization_schedule.destroy!

    respond_to do |format|
      format.html { redirect_to immunization_schedules_url, notice: "Immunization schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #signalwire follow up call

  # def follow_up_call
  #   client = Signalwire::REST::Client.new ENV['SIGNALWIRE_PROJECT_KEY'], ENV['SIGNALWIRE_TOKEN'], signalwire_space_url: ENV['SIGNALWIRE_SPACE']
  
  #   call = client.calls.create(
  #     url: ENV['APP_DOMAIN'],
  #     to: ENV['TO_NUMBER'],
  #     from: ENV['FROM_NUMBER']
  #   )
  #   flash[:notice] = 'Call to Mother Initiated....'

  #   response = Signalwire::Sdk::VoiceResponse.new

  # if params['Digits'] || params['SpeechResult']
  #   # We have input
  #   if params['Digits'] == '1' || params['SpeechResult'].match?(/yes/)
  #     response.say(message: "Thank you for confirming your missed schedule. Goodbye!")
  #     response.hangup
  #   elsif params['Digits'] == '2' || params['SpeechResult'].match?(/no/)
  #     response.say(message: "We will reach out to you for further assistance. Goodbye!")
  #     response.hangup
  #   else
  #     # We didn't understand
  #     response.say(message: "Sorry, I could not understand you.")
  #     response.redirect('/follow_up_missed_schedule?retry=1')
  #   end
  # else
  #   if params['retry'] != '1'
  #     response.say(message: "Hello! This is a follow-up call from BabyShield.")
  #     response.pause(length: 2)
  #     response.say(message: "We noticed that you missed your baby's immunization schedule.")
  #     response.pause(length: 2)
  #     response.say(message: "Did you manage to get the immunization somewhere else? Press 1 for yes, or 2 for no and tell us the reason why.")
  #   end

  #   response.gather(action: '/handle-response', method: 'GET') do |gather|
  #     gather.say(message: "If yes, please press 1. If not, please press 2 and tell us the reason why.")
  #   end
  # end

  # render xml: response.to_s
  #     # Redirect to dashboard on success
  #     redirect_to dashboard_index_path, notice: 'Call to Mother Initiated....'
  #   rescue Signalwire::REST::Error => e
  #     # Handle Twilio API errors and display a flash alert
  #     redirect_to root_path, alert: "Error initiating call: #{e.message}"
  #   end
  # end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_immunization_schedule
      @immunization_schedule = ImmunizationSchedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def immunization_schedule_params
      params.require(:immunization_schedule).permit(:vaxx_name, :scheduled_date, :child_id, :medic_id, :status)
    end
end
