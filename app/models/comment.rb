class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  acts_as_tree order: 'created_at ASC'

end
