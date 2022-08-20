class Grade < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  enum grade_status: {"フラッグシップ":0,"ハイエンド":1,"ミドルレンジ":2,"エントリー":3}
end
