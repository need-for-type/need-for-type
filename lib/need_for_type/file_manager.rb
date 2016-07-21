class FileManager
  FILE_DIR = "../assets"

  attr_accessor :content

  def initialize(difficulty)
    @difficulty = difficulty
    @path = "#{FILE_DIR}/#{@difficulty}"
  end

  # Selects random file from folder
  def load_file
    directory = Dir[@path]
    random_file = rand(1..directory.count)

    # TODO: apply markov's chain's to the text
    @content = File.read("#{@path}/#{random_file}.txt")
  end

  def size
    content.size
  end
end
