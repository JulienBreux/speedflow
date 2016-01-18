module Speedflow
  module Commands
    class Default < Speedflow::Commands::Abstract
      def call(args, options)
        help = (@specs.name.to_s+" ("+@specs.version.to_s+")").capitalize().colorize(:light_blue)+" - "
        help << ("By "+@specs.authors[0]+" <"+@specs.email[0]+">\n").colorize(:light_red)
        help << <<-EOS.strip_heredoc
        Usage: speedflow <command> [options]
        The most commonly used speedflow commands are:
           init    or i         Initilize your project flow
           new     or n         New issue
           review  or r         Review issue
        See `speedflow --help` for more information.
        Or see `speedflow <command> --help` for more information on a specific command.
        EOS
        say(help)
      end
    end
  end
end
