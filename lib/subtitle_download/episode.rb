module SubtitleDownload
  class UnparseableFilename < BaseException ; end

  class Episode
    attr_reader :show, :season, :episode_number

    def initialize(filename)
      @filename = filename

      parse
    end

    private
    def parse
      case @filename
        when /^(.*)s(\d{2})e(\d{2})[^\d]+/i
          @season = $2.to_i
          @episode_number = $3.to_i
          @show = $1.gsub(/(1080|720)p?/,'').gsub(/20\d{2}/,'').gsub('.',' ').rstrip
        else
          raise UnparseableFilename, "cannot parse #{@filename}"
      end
    end
  end
end