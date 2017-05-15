Rails.application.routes.draw do
  root to: 'home#index'

  def api_version(version, &block)
    prefix = "v#{version}"
    scope(prefix, module: prefix, as: "api_#{prefix}", constraints: ApiConstraints.new(version: version), &block)
  end

  api_version(1) do
    resources :videos
  end
end
