class FileManager
  FILE_DIR = "../assets"

  attr_accessor :content

  def initialize(difficulty)
    @difficulty = difficulty
    @path = "#{FILE_DIR}/#{@difficulty}/"
  end

  # Selects random file from folder
  def load_file
    dir_content = Dir[@path]
    file_no = rand(1..dir_content.count)

    # TODO: apply markov's chain's to the text
    @content = File.read("#{@path}/#{file_no}.txt")
  end

  def size
    content.size
  end
end
