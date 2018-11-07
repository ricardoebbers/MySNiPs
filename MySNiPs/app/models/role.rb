class Role < ApplicationRecord
    has_many :users
    validates :role_name, presence: true, uniqueness: true

end
