class Like < ActiveRecord::Base

	validates :user_id,  :uniqueness => { :scope => :post_id, :message => "already likes this post" }

	belongs_to :user
	belongs_to :post

	has_many :notifications, as: :notifiable, dependent: :destroy

end
