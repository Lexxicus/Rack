# init
class App
  def call(env)
    @request = Rack::Request.new(env)
    @get_time = TimeFormat.new(@request)
    [status, headers, body]
  end

  private

  def status
    if @request.path == '/time'
      invalid_format
    else
      404
    end
  end

  def invalid_format
    return 200 unless @get_time.valid?

    400
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    return ["Page Not Found\n"] unless @request.path == '/time'

    ["#{@get_time.time}\n"]
  end
end
