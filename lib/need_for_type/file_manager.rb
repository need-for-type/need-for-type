module NeedForType
  class FileManager
    attr_accessor :content

    def initialize()
      @path = "#{NeedForType::GEM_ROOT}/assets/texts/"
    end

    # Reads random file from difficulty folder
    def get_random_text
      directory_count = Dir[File.join(@path, '**', '*')].count { |file| File.file?(file) }
      random_file = rand(1..directory_count)

      @content = File.read("#{@path}/text-#{random_file}.txt").strip
    end
  end
end
