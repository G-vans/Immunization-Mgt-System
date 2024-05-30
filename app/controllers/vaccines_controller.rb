class VaccinesController < ApplicationController
  before_action :set_vaccine, only: %i[ show edit update destroy ]

  # GET /vaccines or /vaccines.json
  def index
    @vaccines = Vaccine.all.order(:id)

    @low_stock_vaccines = @vaccines.select { |vaccine| vaccine.quantity <= 10 }
    # @products = Product.search(params[:name])
    # @low_stock_products = Product.low_stock

    if @low_stock_vaccines.present?
      low_stock_names = @low_stock_vaccines.map(&:name).join(", ")
      flash.now[:notice] = "#{low_stock_names} #{'are' if @low_stock_vaccines.count > 1} low on stock"
    end

    stockout_sms
    # if @low_stock_products.present?
    #   low_stock_names = @low_stock_products.map(&:name).join(", ")
    #   flash.now[:notice] = "#{low_stock_names} #{"are" if @low_stock_products.count > 1} low on stock"
    # end
  end

  # GET /vaccines/1 or /vaccines/1.json
  def show
  end

  # GET /vaccines/new
  def new
    @vaccine = Vaccine.new
  end

  # GET /vaccines/1/edit
  def edit
  end

  # POST /vaccines or /vaccines.json
  def create
    @vaccine = Vaccine.new(vaccine_params)

    respond_to do |format|
      if @vaccine.save
        format.html { redirect_to vaccine_url(@vaccine), notice: "Vaccine was successfully created." }
        format.json { render :show, status: :created, location: @vaccine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vaccine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vaccines/1 or /vaccines/1.json
  def update
    respond_to do |format|
      if @vaccine.update(vaccine_params)
        format.html { redirect_to vaccines_url, notice: "Vaccine was successfully updated." }
        format.json { render :show, status: :ok, location: @vaccine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vaccine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vaccines/1 or /vaccines/1.json
  def destroy
    @vaccine.destroy!

    respond_to do |format|
      format.html { redirect_to vaccines_url, notice: "Vaccine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def stockout_sms
    @future_schedules = ImmunizationSchedule.where("scheduled_date >= ?", Date.today + 1)
    
    @future_schedules.each do |schedule|
      child = Child.find(schedule.child_id)
      send_sms(child)
    end
  end

  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaccine
      @vaccine = Vaccine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vaccine_params
      params.require(:vaccine).permit(:name, :quantity)
    end

    #send sms
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
