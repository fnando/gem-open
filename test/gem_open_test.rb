require "rubygems"
gem "test-unit"
require "test/unit"
require "mocha"
require "rubygems_plugin"
require "FileUtils"

class GemOpenTest < Test::Unit::TestCase
  def setup
    ENV["GEM_EDITOR"] = "mate"
    @plugin = Gem::Commands::OpenCommand.new
    @gemdir = File.expand_path(File.dirname(__FILE__) + "/gems")
  end

  def test_require_gem_name_to_be_set
    @plugin.expects(:options).returns(:args => [])
    @plugin.expects(:say).with("Usage: #{@plugin.usage}")
    @plugin.expects(:terminate_interaction).returns(true)

    @plugin.execute
  end

  def test_require_installed_gem_name
    gemname = "invalid"

    @plugin.expects(:options).returns(:args => [gemname])
    @plugin.expects(:search).with(gemname).returns(nil)
    @plugin.expects(:say).with("The #{gemname.inspect} gem couldn't be found")
    @plugin.expects(:terminate_interaction).returns(true)

    @plugin.execute
  end

  def test_gem_without_version
    gemname = "activesupport"

    Gem::SourceIndex.expects(:installed_spec_directories).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    @plugin.expects(:system).with("mate #{@gemdir}/activesupport-3.0.0.beta3")

    @plugin.execute
  end

  def test_gem_with_version
    gemname = "activesupport-2.3.5"

    Gem::SourceIndex.expects(:installed_spec_directories).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    @plugin.expects(:system).with("mate #{@gemdir}/activesupport-2.3.5")

    @plugin.execute
  end

  def test_unset_editor
    ENV["GEM_EDITOR"] = nil
    gemname = "activesupport"

    Gem::SourceIndex.expects(:installed_spec_directories).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    @plugin.expects(:say).with("You must set your editor in your .bash_profile or equivalent:")
    @plugin.expects(:say).with("  export GEM_EDITOR='mate'")
    @plugin.expects(:terminate_interaction)

    @plugin.execute
  end
end
