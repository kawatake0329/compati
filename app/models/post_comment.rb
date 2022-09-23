class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  def avg_score
    unless self.rate.empty?
      comments.average(:rate_id).round(1)
    else
      0.0
    end
  end

  def avg_score_percentage
    unless self.comments.empty?
     comments.average(:rate_id).round(1).to_f*100/5
    else
     0.0
    end
  end

  def rate_count
    post_comments.average(:rate).to_f.round(1)
  end
end
