# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :set_record
  before_action :set_attachment, only: %i[destroy]

  # GET /attachments or /attachments.json
  def index
    @attachments = @record.attachments
  end

  def new; end

  def create
    respond_to do |format|
      if @record.update(record_params)
        @record.reload

        notice = t('attachments.create.success')
        format.html { redirect_to @record, notice: }
        format.json { render :show, status: :created, location: @cost_center }
        format.turbo_stream { flash.now.notice = notice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1 or /attachments/1.json
  def destroy
    @attachment.purge_later
    @record.reload

    respond_to do |format|
      notice = t('attachments.destroy.success')
      format.html { redirect_to @record, notice: }
      format.json { head :no_content }
      format.turbo_stream { flash.now.notice = notice }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attachment
    @attachment = @record.attachments.find(params[:id])
  end

  def record_params
    params.permit(attachments: [])
  end
end
