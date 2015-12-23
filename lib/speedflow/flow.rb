module Speedflow
  class Flow
    attr_accessor :vsc, :scm, :pm

    def initialize(project_path)
      @project_path = project_path
    end
  end
end
