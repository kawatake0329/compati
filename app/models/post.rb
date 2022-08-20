class Post < ApplicationRecord
  belongs_to :grade
  belongs_to :customer
end
