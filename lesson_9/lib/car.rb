require_relative '../modules/accessors'
require_relative '../modules/validation'

class Car
  extend Accessors
  include Validation
  attr_accessor_with_history :model, :serial_number
  strong_attr_accessor :issue_year, Integer

  validate :model, :presence
  validate :serial_number, :format, /^[\d\w]{3}-[\d]{2}-[\w]$/i
  validate :issue_year, :type, Integer
end
