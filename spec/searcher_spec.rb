require 'spec_helper'
require 'digest/md5'

describe Searcher do
  before :all do
    @episode = Episode.new 'Sons.of.Anarchy.S06E13.720p.HDTV.x264-2HD.mkv'
    @searcher = Searcher.new(@episode)
  end

  it 'should be able to find links' do
    @searcher.links.should_not be_empty

    @searcher.links.should include('http://www.podnapisi.net/nl/sons-of-anarchy-2008-subtitles-p2786514')
    @searcher.links.should include('http://www.podnapisi.net/nl/sons-of-anarchy-2008-subtitles-p2784583')
  end

  it 'should be able to download links' do
    @searcher.download_links('/tmp')

    files = [
      {
          :path => "/tmp/Sons of Anarchy - 06x13 - A Mother's Work.WEB-DL.English.orig.srt",
          :md5  => 'c9c11b17ade210292e635e7389e6fee2'
      },
      {
          :path => "/tmp/Sons of Anarchy.S06E13.HDTV.x264-2HD.srt",
          :md5  => 'aa42816715c781d41606a167d1677b8f'
      }
    ]

    files.each do |hash|
      File.exist?(hash[:path]).should be(true)
      Digest::MD5.hexdigest(File.read(hash[:path])).should eq(hash[:md5])
    end

  end
end
