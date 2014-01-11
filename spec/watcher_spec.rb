require 'spec_helper'
require 'tmpdir'
require 'fileutils'
require 'pathname'

describe Watcher do
  let(:options) { Hash.new }

  before do
    @tmpdir = Pathname.new Dir::mktmpdir

    callback = Proc.new do |modified, added, removed|
      options[:modified] = modified
      options[:added] = added
      options[:removed] = removed
    end

    @watcher = Watcher.new(@tmpdir, callback)
    @watcher.start
  end

  after do
    @watcher.stop
    FileUtils.remove_dir(@tmpdir)
  end

  it 'should be notified when a file arrives in a watch directory' do
    file = @tmpdir.join('Sons of Anarchy S01E01.mkv')
    FileUtils.touch file
    sleep 0.5

    options[:added].should eq([file.to_s])
  end

  it 'should not trigger on anything but mkv/mp4/avi' do
    file = @tmpdir.join('Sons of Anarchy S01E02.abc')
    FileUtils.touch file
    sleep 0.5

    options[:added].should eq(nil)
  end
end
