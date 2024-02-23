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

  #twilio follow up call

  def follow_up_call
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  
    begin
      call = @client.calls.create(
        url: 'http://demo.twilio.com/docs/voice.xml',
        to: '+254727538865',
        from: '+15755793821'
      )

      flash[:notice] = 'Call to Mother Initiated....'
  
      # Redirect to dashboard on success
      redirect_to immunization_schedules_path, notice: 'Call to Mother Initiated....'
    rescue Twilio::REST::TwilioError => e
      # Handle Twilio API errors and display a flash alert
      redirect_to root_path, alert: "Error initiating call: #{e.message}"
    end
  end
  

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
