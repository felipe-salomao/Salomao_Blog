module PostScopes
  extend ActiveSupport::Concern

  included do
    scope :desc_order, -> { order(created_at: :desc) }
    scope :asc_order, -> { order(created_at: :asc) }
    scope :without_highlights, ->(ids) { where.not(id: ids.split(',')) if ids.present? }
    scope :filter_by_category, ->(category) { where category_id: category.id if category.present? }
    scope :filter_by_archive, lambda { |month_year|
      if month_year
        date = Date.strptime(month_year, '%B %Y')
        where created_at: date.beginning_of_month..date.end_of_month.next_day
      end
    }
  end
end
