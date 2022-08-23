class Tag < ApplicationRecord
  has_many :post_tags,dependent: :destroy, foreign_key: 'tag_id'
  #複数の投稿をタグは持つため、post_tagsを通じて参照できる
  has_many :posts,through: :post_tags

  validates :name, uniqueness: true, presence: true
end
