class ImmunizationSchedulesController < ApplicationController
  before_action :set_immunization_schedule, only: %i[ show edit update destroy ]

  # GET /immunization_schedules or /immunization_schedules.json
  def index
    @immunization_schedules = ImmunizationSchedule.all
  end

  # GET /immunization_schedules/1 or /immunization_schedules/1.json
  def show
  end

  # GET /immunization_schedules/new
  def new
    @immunization_schedule = ImmunizationSchedule.new
  end

  # GET /immunization_schedules/1/edit
  def edit
  end

  # POST /immunization_schedules or /immunization_schedules.json
  def create
    @immunization_schedule = ImmunizationSchedule.new(immunization_schedule_params)

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
