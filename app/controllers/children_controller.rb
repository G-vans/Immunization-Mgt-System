class ChildrenController < ApplicationController
  before_action :set_child, only: %i[ show edit update destroy ]

  # GET /children or /children.json
  def index
    if params[:name].present?
      search_term = "%#{params[:name].downcase}%"
      @children = Child.where("lower(baby_name) LIKE ?", search_term)
    else
      @children = Child.all
    end
  end

  # GET /children/1 or /children/1.json
  def show
    @child = Child.find(params[:id])
    @baby_schedules = @child.immunization_schedules
  end

  # GET /children/new
  def new
    @child = Child.new
  end

  # GET /children/1/edit
  def edit
  end

  def update_status
    @child = Child.find(params[:child_id]) 
    @schedule = @child.immunization_schedules.find(params[:id])
    if @schedule.update(status: true)
      flash[:notice] = "Immunization status updated successfully."
    else
      flash[:error] = "Failed to update immunization status."
    end
    redirect_to child_path(@child)
  end 

  # POST /children or /children.json
  def create
    @child = Child.new(child_params)

    respond_to do |format|
      if @child.save
        # send_sms(@child)
        format.html { redirect_to child_url(@child), notice: "Child was successfully created." }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /children/1 or /children/1.json
  def update
    respond_to do |format|
      if @child.update(child_params)
        format.html { redirect_to child_url(@child), notice: "Child was successfully updated." }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1 or /children/1.json
  def destroy
    @child.destroy!

    respond_to do |format|
      format.html { redirect_to children_url, notice: "Child was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def child_params
      params.require(:child).permit(:baby_name, :parent_name, :date_of_birth, :gender, :phone_number, :weight, :language)
    end

    def send_sms(child)
      
        username = "Gvans"
        apikey = ENV["AT_APIKEY"]
      
        # Initialize the SDK
        @AT = AfricasTalking::Initialize.new(username, apikey)
      
        sms = @AT.sms
      
      baby = child.baby_name
      parent = child.parent_name
      to = child.phone_number
      
        # Send the welcome message
        message = "Welcome, #{parent}! Get ready for Chanjo, your ultimate immunization reminder app for your precious little one, #{baby}. We'll ensure you never miss a vaccination appointment. Stay tuned for regular reminders and keep your baby protected!"
        
      
        options = {
          "to" => to,
          "message" => message
        }
      
        begin
          # Send the SMS and retrieve the response
          response = sms.send(options)
      
          # Log success or any necessary information
          Rails.logger.info "SMS sent successfully"
        rescue AfricasTalking::AfricasTalkingException => ex
          # Log error or any necessary information
          Rails.logger.error "Failed to send SMS: #{ex.message}"
        end
        
      end

end
