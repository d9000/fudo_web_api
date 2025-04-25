# frozen_string_literal: true

class FileRender
  def self.v1_render(res, file_name, cache_control)
    res['Cache-Control'] = cache_control
    file_path = File.join(File.dirname(__FILE__), '..', 'endpoints', 'v1', file_name)
    res.write(File.read(file_path))
  end
end
