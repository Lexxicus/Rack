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

  def time
    check_formats
    if valid?
      Time.now.strftime(@valid.join('-'))
    else
      "Unknown time format #{@invalid}"
    end
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
