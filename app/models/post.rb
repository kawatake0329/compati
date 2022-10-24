class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :specs, dependent: :destroy

  validates :title, presence: true
  validates :cpu, presence: true
  validates :memory, presence: true
  validates :storage, presence: true
  validates :graphic_board, presence: true


  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  scope :latest, -> {order(updated_at: :desc)}
  scope :old, -> {order(updated_at: :asc)}
  scope :rank, -> {
    left_joins(:post_comments).
    group(:id).
    order('avg(rate) desc')}

  def self.looks(search, word)
    # 完全一致の場合の処理
    if search == "perfect_match"
      @post = Post.where("title LIKE? OR mother_board LIKE?
      OR cpu LIKE? OR memory LIKE? OR storage LIKE?
      OR graphic_board LIKE? OR case LIKE? OR case_fan LIKE?
      OR power LIKE? OR compatibility LIKE? OR description LIKE?",
      "#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}")
    # 前方一致の場合の処理
    elsif search == "forward_match"
      @post = Post.where("title LIKE? mother_board LIKE?
      OR cpu LIKE? OR memory LIKE? OR storage LIKE?
      OR graphic_board LIKE? OR case LIKE? OR case_fan LIKE?
      OR power LIKE? OR compatibility LIKE? OR description LIKE?",
      "#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}")
    # 後半一致の場合の処理
    elsif search == "backward_match"
      @post = Post.where("title LIKE? mother_board LIKE?
      OR cpu LIKE? OR memory LIKE? OR storage LIKE?
      OR graphic_board LIKE? OR case LIKE? OR case_fan LIKE?
      OR power LIKE? OR compatibility LIKE? OR description LIKE?",
      "#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}")
    # 部分一致の場合の処理
    elsif search == "partial_match"
      @post = Post.where("title LIKE? mother_board LIKE?
      OR cpu LIKE? OR memory LIKE? OR storage LIKE?
      OR graphic_board LIKE? OR case LIKE? OR case_fan LIKE?
      OR power LIKE? OR compatibility LIKE? OR description LIKE?",
      "#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}","#{word}")
    else
      @post = Post.all
    end
  end
end
