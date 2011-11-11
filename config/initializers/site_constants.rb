# Application constants
# Changes here require server restart

# CONGRESS_YEAR is the year representing the upcoming congress,
# not necessarily the same as the current calendar year.
CONGRESS_YEAR = 2012

# LATEST_YEAR is usually the same as CONGRESS_YEAR,
# or if we are planning a year ahead but haven't rolled
# it out yet, then LATEST_YEAR may == CONGRESS_YEAR + 1
LATEST_YEAR = 2012

# CONGRESS_START_DATE is the first day of the congress
# For now, keep this a constant so that the attendee model
# can calculate "age on start date".  If I move this to the
# application controller, for example, the model would be
# unable to access it.
CONGRESS_START_DATE = {
  2011 => Date.civil(2011, 7, 30),
  2012 => Date.civil(2012, 8, 4)
}

# DAY_OFF_DATE - The go congress traditionally has one "day off". 
# Currently, this only affects the display of this particular day
# on the event and tournament calendars.
DAY_OFF_DATE = {
  2011 => Date.civil(2011, 8, 3),
  2012 => Date.civil(2012, 8, 8)
}
