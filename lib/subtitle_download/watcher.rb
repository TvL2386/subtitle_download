require 'listen'

module SubtitleDownload
  class Watcher
    def initialize(directories, callback)
      @listener = Listen.to(directories, only: only, &callback)
    end

    def start
      @listener.start
    end

    def stop
      @listener.stop
    end

    private
    def only
      /\.(mkv|avi|mp4)$/i
    end
  end
end