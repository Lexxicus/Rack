# init
class App
  def call(env)
    @request = Rack::Request.new(env)
    request_time
  end

  def request_time
    if @request.path == '/time'
      process_params
    else
      response('not found', 404)
    end
  end

  def response(body, status)
    Rack::Response.new(body, status, headers)
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  private

  def process_params
    tf = TimeFormat.new(@request)
    tf.call
    if tf.valid?
      response(tf.time_string, 200)
    else
      response(tf.invalid_format, 400)
    end
  end
end
