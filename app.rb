# init
class App
  def call(env)
    perfom_request
    [status, headers, body]
  end

  def perfom_request
    sleep rand(1..3)
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["Welcome aboard!\n"]
  end
end
