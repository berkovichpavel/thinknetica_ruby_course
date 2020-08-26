DAYS_IN_A_MONTH = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}.freeze

DAYS_IN_A_MONTH.each { |key, value| puts key.to_s if value == 30 }
