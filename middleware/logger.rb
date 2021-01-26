require 'logger'
# init
class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || $stdout)
    @app = app
  end

  def call(env)
    @logger.info(env)
    @app.call(env)
  end
end
