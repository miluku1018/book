class Publisher < ApplicationRecord
    validates :name, presence: true
    scope :available, -> { where(online: true) }

    has_many :books
end
