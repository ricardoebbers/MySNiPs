class Genoma < ApplicationRecord
    belongs_to :user

    def to_json_view
        {
            status: status,
            updated_at: updated_at
        }
    end
end
