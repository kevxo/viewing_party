class Image
  attr_reader :path
  def initialize(image_data)
    @path = "https://image.tmdb.org/t/p/w400#{image_data[:file_path]}"
  end
end
