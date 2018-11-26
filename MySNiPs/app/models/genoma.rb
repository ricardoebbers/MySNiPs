class Genoma < ApplicationRecord
  belongs_to :user

  def to_json_view
    {
      status:     status,
      updated_at: updated_at
    }
  end

  def match_complete
    update_attribute(:file, nil)
    update_attribute(:status, "Sucesso")
  end

  def match_error
    update_attribute(:file, nil)
    update_attribute(:status, "Falha")
  end
end
