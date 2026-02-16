class AllowNullDestinationOnTrips < ActiveRecord::Migration[7.1]
  def change
    change_column_null :trips, :destination_id, true
  end
end
