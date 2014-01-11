require 'spec_helper'

describe Episode do
  before :all do
    @episode = Episode.new('My.Cool.Show.2004.720p.S07E12.HDTV.x264-LOL.mp4')
  end

  it 'should be able to find the show' do
    @episode.show.should eq('My Cool Show')
  end

  it 'should be able to determine the season' do
    @episode.season.should eq(7)
  end

  it 'should be able to determine the episode number' do
    @episode.episode_number.should eq(12)
  end
end
