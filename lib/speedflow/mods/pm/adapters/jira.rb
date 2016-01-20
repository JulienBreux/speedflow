module Speedflow
  module Mods
    module PM
      # Project manager adapters
      module Adapters
        require 'net/http'
        require 'uri'
        require 'json'

        # Jira PM adapter
        class Jira < Speedflow::Adapter
          DEFAULT_PORT = 443
          DEFAULT_TYPE = 'Task'.freeze
          ISSUE_PATH = 'rest/api/2/issue/'.freeze

          # Public: Create issue
          # TODO Manage exceptions
          #
          # subject - Subject.
          # type    - Type of issue.
          #
          # Examples
          #
          #    create_issue('hello world', 'Bug')
          #
          # Returns JSON of issue.
          def create_issue(subject, type = DEFAULT_TYPE)
            # TODO: Check settings
            data = {
              fields: {
                project: { key: @settings[:project] },
                summary: subject,
                issuetype: { name: type }
              }
            }

            uri = URI(url + ISSUE_PATH)
            req = Net::HTTP::Post.new(
              uri.path,
              initheader: { 'Content-Type' => 'application/json' }
            )
            req.basic_auth(ENV['JIRA_USER'], ENV['JIRA_PASSWORD'])
            req.body = data.to_json

            net = Net::HTTP.new(uri.host, uri.port)
            net.use_ssl = true
            # http.set_debug_output $stderr
            resp = net.start { |http| http.request(req) }

            JSON.parse(resp.body)
          end

          # Public: Read issue
          # TODO In progress
          #
          # key - Key of issue.
          #
          # Examples
          #
          #    read_issue('SF-01')
          #
          # Returns JSON of issue.
          def read_issue(_key)
            'TMP'
          end

          # Public: Request configuration from user CLI interaction
          #
          # Examples
          #
          #    ask_configuration
          #    # => nil
          #
          # Returns nothing.
          def ask_config!
            host = ask('Host?'.colorize(:light_blue), String) do |q|
              q.default = get(:host)
            end
            set(:host, host.to_s)

            port = ask('Port?'.colorize(:light_blue), Integer) do |q|
              q.default = DEFAULT_PORT.to_s
            end
            set(:port, port.to_i) unless DEFAULT_PORT == port.to_i

            project = ask('Project ID?'.colorize(:light_blue), String) do |q|
              q.default = get(:project)
            end
            set(:project, project.to_s)

            # TODO: Fix response
            # TODO Add abstract
            question = 'Create issue in Jira? (y/n)'
            issue_create = agree(question.colorize(:light_blue))
            set(:create_issue, issue_create)

            # TODO: Add notice method
            notice = 'Think to add this following lines to your ~/.Xrc file:'
            say(notice.colorize(color: :black, background: :light_blue))
            notice = 'export JIRA_USER=username'
            say(notice.colorize(:grey))
            notice = 'export JIRA_PASSWORD=password'
            say(notice.colorize(:grey))
          end

          protected

          # Public: Get url
          # TODO Move
          #
          # Examples
          #
          #    url
          #    # => https://xxx.com:123/
          #
          # Returns string of URL.
          def url
            port = @settings[:port] || DEFAULT_PORT

            site = 'http' + (port == 443 ? 's' : '') + '://'
            site << @settings[:host]
            site << (':' + port.to_s) unless 80 == @settings[:port]
            site << '/'
            site
          end
        end
      end
    end
  end
end
