class Book < ActiveRecord::Base
  belongs_to :author
  accepts_nested_attributes_for :author
end
