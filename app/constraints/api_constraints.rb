class ApiConstraints
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request.path =~ /v#{version}/i && request.format.json?
  end
end
