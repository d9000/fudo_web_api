class FileRender
  def self.render(res, file_path, cache_control)
    res['Cache-Control'] = cache_control
    res.write(File.read(file_path))
  end
end
