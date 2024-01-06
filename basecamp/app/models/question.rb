# https://dev.37signals.com/active-record-nice-and-blended/

class Question < ApplicationRecord
  serialize :schedule, RecurrenceSchedule
end