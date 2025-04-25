require 'zlib'
require 'stringio'

class Gzip
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env['HTTP_ACCEPT_ENCODING']&.include?('gzip')
      compressed_body = compress(body.join)
      headers['Content-Encoding'] = 'gzip'
      headers['Content-Length'] = compressed_body.bytesize.to_s
      body = [compressed_body]
    end

    [status, headers, body]
  end

  private

  def compress(body)
    string_io = StringIO.new
    gzip_writer = Zlib::GzipWriter.new(string_io)
    gzip_writer.write(body)
    gzip_writer.close
    string_io.string
  end
end
