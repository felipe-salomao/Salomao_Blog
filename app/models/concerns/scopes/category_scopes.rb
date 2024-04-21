module CategoryScopes
  extend ActiveSupport::Concern

  included do
    scope :sorted, -> { order(:name) }
  end
end
