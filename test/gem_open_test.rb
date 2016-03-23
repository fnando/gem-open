require "bundler/setup"

require "minitest"
require "minitest/utils"
require "minitest/autorun"
require "mocha/mini_test"
require "rubygems_plugin"
require "fileutils"

class GemOpenTest < Minitest::Test
  def setup
    ENV["GEM_EDITOR"] = "mate"
    @plugin = Gem::Commands::OpenCommand.new
    @gemdir = File.expand_path(File.dirname(__FILE__) + "/gems")
  end

  def test_use_gem_specification_dirs
    Gem::Specification.expects(:respond_to?).with(:dirs).returns(true)
    Gem::Specification.expects(:dirs).returns(["/some/dir"])

    assert_equal ["/some/dir"], @plugin.dirs
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

  def test_open_gem_using_gem_editor_variable
    ENV["GEM_EDITOR"] = "mate"
    ENV["EDITOR"] = "vim"

    gemname = "activesupport"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/activesupport-3.0.0.beta3").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/activesupport-3.0.0.beta3")

    @plugin.execute
  end

  def test_open_gem_using_editor_variable
    ENV["GEM_EDITOR"] = nil
    ENV["EDITOR"] = "vim"

    gemname = "activesupport"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/activesupport-3.0.0.beta3").yields
    @plugin.expects(:system).with("vim", "#{@gemdir}/activesupport-3.0.0.beta3")

    @plugin.execute
  end

  def test_gem_without_version
    gemname = "activesupport"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/activesupport-3.0.0.beta3").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/activesupport-3.0.0.beta3")

    @plugin.execute
  end

  def test_gem_with_version
    gemname = "activesupport-2.3.5"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/activesupport-2.3.5").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/activesupport-2.3.5")

    @plugin.execute
  end

  def test_gem_with_compound_name
    gemname = "sinatra-sugar"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/sinatra-sugar-0.4.1").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/sinatra-sugar-0.4.1")

    @plugin.execute
  end

  def test_gem_with_compound_name_and_version
    gemname = "sinatra-sugar-0.4.1"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/sinatra-sugar-0.4.1").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/sinatra-sugar-0.4.1")

    @plugin.execute
  end

  def test_gem_with_alphanumeric_name
    gemname = "imgur2"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/imgur2-1.2.0").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/imgur2-1.2.0")

    @plugin.execute
  end

  def test_gem_with_alphanumeric_name_and_version
    gemname = "imgur2-1.2.0"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/imgur2-1.2.0").yields
    @plugin.expects(:system).with("mate", "#{@gemdir}/imgur2-1.2.0")

    @plugin.execute
  end

  def test_parse_editor
    ENV["GEM_EDITOR"] = "mate -H '/Users/My Home/Code and Stuff'"
    gemname = "imgur2-1.2.0"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    Dir.expects(:chdir).with("#{@gemdir}/imgur2-1.2.0").yields
    @plugin.expects(:system).with("mate", "-H", "/Users/My Home/Code and Stuff", "#{@gemdir}/imgur2-1.2.0")

    @plugin.execute
  end

  def test_unset_editor
    ENV["GEM_EDITOR"] = nil
    ENV["EDITOR"] = nil
    gemname = "activesupport"

    @plugin.expects(:dirs).returns([File.dirname(__FILE__) + "/resources"])

    @plugin.expects(:options).returns(:args => [gemname])
    @plugin.expects(:say).with("You must set your editor in your .bash_profile or equivalent:")
    @plugin.expects(:say).with("  export GEM_EDITOR='mate'")
    @plugin.expects(:say).with("or")
    @plugin.expects(:say).with("  export EDITOR='mate'")
    @plugin.expects(:terminate_interaction)

    @plugin.execute
  end
end
