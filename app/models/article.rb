class Article < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true,
										length: { minimum: 5 }
	validates :text, length: { minimum: 50 },
									 format: { without: /<script/,
									 						message: "Text can not contain JavaScript"}
end
