require "shellwords"

class Gem::Commands::OpenCommand < Gem::Command
  def description
    "Open a gem into your favorite editor"
  end

  def arguments
    "GEM       gem's name"
  end

  def usage
    "#{program_name} GEM"
  end

  def initialize
    super "open", description
  end

  def execute
    gemname = options[:args].first

    unless gemname
      say "Usage: #{usage}"
      return terminate_interaction
    end

    spec = search(gemname)

    if spec
      open(spec)
    else
      say "The #{gemname.inspect} gem couldn't be found"
      return terminate_interaction
    end
  end

  def dirs
    if Gem::Specification.respond_to?(:dirs)
      Gem::Specification.dirs
    else
      Gem::SourceIndex.installed_spec_directories
    end
  end

  def search(gemname)
    regex = /^(.*?)(-+[\d.]+[\w]*)?$/
    _, required_name, required_version = *gemname.match(regex)

    gemspecs = Dir["{#{dirs.join(",")}}/*.gemspec"].select do |gemspec|
      basename = File.basename(gemspec).gsub(/\.gemspec$/, "")

      if required_version
        basename == gemname
      else
        _, name, version = *basename.match(regex)
        name == gemname
      end
    end

    gemspec = gemspecs.sort.last

    return unless gemspec

    Gem::Specification.load(gemspec)
  end

  def open(spec)
    editor = ENV["GEM_EDITOR"] || ENV["EDITOR"]

    if editor
      path = spec.full_gem_path
      Dir.chdir(path) do
        system(*Shellwords.split(editor), path)
      end
    else
      say "You must set your editor in your .bash_profile or equivalent:"
      say "  export GEM_EDITOR='mate'"
      say "or"
      say "  export EDITOR='mate'"
      return terminate_interaction
    end
  end
end
