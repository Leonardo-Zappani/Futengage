# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  include Audited::ActiveJob
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  discard_on ActiveJob::DeserializationError

  before_perform do |_job|
    Current.user = audit_user
  end
end
