class Board < ApplicationRecord
  before_save :serialize_array_fields

  def vertical_walls
    ActiveSupport::JSON.decode(read_attribute(:vertical_walls))
  end

  def horizontal_walls
    ActiveSupport::JSON.decode(read_attribute(:horizontal_walls))
  end

  private

  def serialize_array_fields
    self.vertical_walls   = ActiveSupport::JSON.encode(self.vertical_walls)
    self.horizontal_walls = ActiveSupport::JSON.encode(self.horizontal_walls)
  end

end
