# frozen_string_literal: true

class CostCentersController < ApplicationController
  before_action :set_cost_center, only: %i[show edit update destroy]

  # GET /cost_centers or /cost_centers.json
  def index
    authorize! :read, CostCenter
    query = current_account.cost_centers.sort_by_params(sort_column(CostCenter, default: :name), sort_direction)
    query = query.search_by_q(params[:q]) if params[:q].present?

    @pagy, @records = pagy(query)

    @records.load
  end

  # GET /cost_centers/1 or /cost_centers/1.json
  def show; end

  # GET /cost_centers/new
  def new
    authorize! :create, CostCenter

    @cost_center = CostCenter.new
  end

  # GET /cost_centers/1/edit
  def edit; end

  # POST /cost_centers or /cost_centers.json
  def create
    authorize! :create, CostCenter

    @cost_center = current_account.cost_centers.new(cost_center_params)

    respond_to do |format|
      if @cost_center.save
        notice = t('.success')
        format.html { redirect_to cost_centers_url, notice: }
        format.json { render :show, status: :created, location: @cost_center }
        format.turbo_stream { flash.now.notice = notice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cost_centers/1 or /cost_centers/1.json
  def update
    authorize! :update, CostCenter

    respond_to do |format|
      if @cost_center.update(cost_center_params)
        notice = t('.success')
        format.html { redirect_to cost_centers_url, notice: }
        format.json { render :show, status: :ok, location: @cost_center }
        format.turbo_stream { flash.now.notice = notice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cost_centers/1 or /cost_centers/1.json
  def destroy
    authorize! :destroy, CostCenter

    @cost_center.destroy_or_discard
    respond_to do |format|
      notice = t('.success')
      format.html { redirect_to cost_centers_url, notice: }
      format.json { head :no_content }
      format.turbo_stream { flash.now.notice = notice }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cost_center
    @cost_center = current_account.cost_centers.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cost_center_params
    params.require(:cost_center).permit(:name, :description)
  end
end
