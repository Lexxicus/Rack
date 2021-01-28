# init
class App
  def call(env)
    @request = Rack::Request.new(env)
    request_time
    [@status, headers, [@body]]
  end

  def request_time
    if @request.path == '/time'
      process_params
    else
      @body = 'not found'
      @status = 404
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  private

  def process_params
    tf = TimeFormat.new(@request)
    tf.call
    if tf.valid?
      @body = tf.time_string
      @status = 200
    else
      @body = tf.invalid_format
      @status = 400
    end
  end
end
