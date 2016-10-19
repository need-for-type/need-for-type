module NeedForType
  class FileManager
    attr_accessor :text, :text_id

    def initialize()
      @path = "#{NeedForType::GEM_ROOT}/assets/texts/"
    end

    def read_random_text
      directory_count = Dir[File.join(@path, '**', '*')].count
      @text_id = rand(1..directory_count)
      @text = File.read("#{@path}/text-#{@text_id}.txt").strip
    end
  end
end
