require 'listen'
require 'pathname'

module SubtitleDownload
  class Watcher
    def initialize(directories, callback)
      @directories, @callback = directories, callback
      @directories = [@directories] unless @directories.is_a?(Array)
      @listener = Listen.to(@directories, only: only_regex, &check_and_callback)
    end

    def start
      @listener.start
    end

    def stop
      @listener.stop
    end

    private
    def only_regex
      /\.(mkv|avi|mp4)$/i
    end

    def check_and_callback
      Proc.new do |modified, added, removed|
        modified.keep_if { |file| file_to_keep?(file) }
        added.keep_if { |file| file_to_keep?(file) }
        removed.keep_if { |file| file_to_keep?(file) }

        if modified.any? or added.any? or removed.any?
          @callback.call(modified, added, removed)
        end
      end
    end

    def file_to_keep? file
      basename = Pathname.new(file).basename.to_s

      @directories.detect { |d| Pathname.new(d).join(basename).to_s == file }
    end
  end
end