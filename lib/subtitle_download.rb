module SubtitleDownload
  class BaseException < Exception ; end

  def self.run(directory)
    callback = Proc.new do |modified, added, removed|
      added.each do |file|
        begin
          puts "Searching subtitles for #{file.inspect}"

          searcher = Searcher.new(Episode.new(file))
          searcher.download_links(directory)
          puts 'Done!'
        rescue Exception => e
          puts "Something went wrong for: #{file}"
          puts "Exception class: #{e.class}"
          puts "Exception message: #{e.message}"
          puts 'Backtrace:'
          puts e.backtrace.join("\n")
          puts '###############################'
          puts
        end
      end
    end

    watcher = Watcher.new(directory, callback)
    watcher.start
  end
end

require 'subtitle_download/version'
require 'subtitle_download/episode'
require 'subtitle_download/searcher'
require 'subtitle_download/watcher'
