class Micropost < ApplicationRecord
  belongs_to :user
  # 登録・更新時にcontentに対して検証を行う
  # 値が空でないこと、140文字以内であること
  validates :content, presence: true, length: { maximum: 140 }
end
