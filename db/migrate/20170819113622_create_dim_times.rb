class CreateDimTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :dim_times do |t|
      t.date :date
      t.integer :year
      t.integer :month
      t.text :monthname
      t.integer :day
      t.integer :dayofyear
      t.text :weekdayname
      t.integer :calendarweek
      t.text :formatteddate
      t.text :quartal
      t.text :yearquartal
      t.text :yearmonth
      t.text :yearcalendarweek
      t.text :weekend
      t.text :americanholiday
      t.text :austrianholiday
      t.text :canadianholiday
      t.text :period
      t.date :cwstart
      t.date :cwend
      t.date :monthstart
      t.date :monthend

      t.timestamps
    end
  end
end
