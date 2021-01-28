class TimeFormat
  VALID_FORMAT = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  attr_reader :invalid

  def initialize(request)
    @request = request
    @valid = []
    @invalid = []
  end

  def valid?
    @invalid.empty?
  end

  def time_string
    Time.now.strftime(@valid.join('-'))
  end

  def invalid_format
    "Unknown time format #{@invalid}"
  end

  def call
    check_formats
  end

  private

  def check_formats
    formats = @request.params['format'].split(',')
    formats.each do |format|
      if VALID_FORMAT[format]
        @valid << VALID_FORMAT[format]
      else
        @invalid << format
      end
    end
  end
end
