require 'zlib'
require 'stringio'

class Gzip
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env['HTTP_ACCEPT_ENCODING']&.include?('gzip')
      headers['Content-Encoding'] = 'gzip'
      body = [compress(body.join)]
    end

    [status, headers, body]
  end

  private

  def compress(body)
    string_io = StringIO.new
    gzip_writer = Zlib::GzipWriter.new(string_io)
    gzip_writer.write(body.join)
    gzip_writer.close
    string_io.string
  end
end
