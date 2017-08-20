class Crime < ApplicationRecord
	self.table_name = "fact_crimes"
  belongs_to :communityarea
  belongs_to :dimtime
  belongs_to :iucr
  belongs_to :location
end
