class VaccinesController < ApplicationController
  before_action :set_vaccine, only: %i[ show edit update destroy ]

  # GET /vaccines or /vaccines.json
  def index
    @vaccines = Vaccine.all.order(:id)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaccine
      @vaccine = Vaccine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vaccine_params
      params.require(:vaccine).permit(:name, :status)
    end
end
