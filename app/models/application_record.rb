class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.pagination(page, per_page)
    page = page.to_i
    per_page = per_page.to_i
    limit(per_page).offset((page - 1) * per_page)
  end
end
