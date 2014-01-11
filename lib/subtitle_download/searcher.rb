require 'nokogiri'
require 'open-uri'
require 'uri'
require 'zip'
require 'stringio'
require 'pathname'

module SubtitleDownload
  class Searcher
    def initialize(episode)
      @episode = episode
    end

    def links
      @links || find_links
    end

    def download_links(to)
      zip_links.each do |link|
        Zip::InputStream.open(open(link)) do |zis|
          while (entry = zis.get_next_entry)
            filename = Pathname.new(to).join(entry.name)
            File.write(filename, zis.read)
          end
        end
      end
    end

    private
    def zip_links
      @zip_links ||= links.map do |link|
        base + zip_document(link).css('a.button.big.download').first.attribute('href').to_s
      end
    end

    def find_links
      @links = []

      unless document.content.match /Geen ondertitels gevonden./
        # get tr elements from specific table
        rows = document.css('table.first_column_title tr').to_a

        # reject th elements
        rows.reject! { |row| row.css('th').count > 0 }

        # reject hearing impaired
        rows.reject! { |tr| tr.css('div.subtitles_flags div.n').count > 0 }

        rows.each do |row|
          columns = row.css('td').to_a
          link = base + columns[0].css('div')[1].css('a').first.attribute('href').value

          @links << link
        end
      end

      @links
    end

    def base
      'http://www.podnapisi.net'
    end

    def url
      '%s/nl/ppodnapisi/search?sT=1&sJ=2&sK=%s&sTS=%d&sTE=%d' % ([base, show, season, number])
    end

    def show
      URI.encode @episode.show
    end

    def season
      @episode.season
    end

    def number
      @episode.episode_number
    end

    def document
      @document ||= Nokogiri::HTML open(url)
    end

    def zip_document(link)
      Nokogiri::HTML open(link)
    end
  end
end