module Imports
  module Constants
    extend ActiveSupport::Concern
    IMPORTS_STATES = {
      in_progress: 0,
      done: 1,
      failed: 2,
      waiting: 3,
    }.freeze

    IMPORTS_SOURCES = {
      zero_paper: 0,
    }
  end
end
