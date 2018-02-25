class Tweet < ApplicationRecord
  belongs_to :user
  default_scope { order(tid: :desc) }
end
