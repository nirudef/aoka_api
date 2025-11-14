# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://aoka.kz", "https://aoka.қаз", "https://aoka.xn--80ao21a", "http://localhost:3000"
    resource "*",
             headers: :any,
             # expose: ["Authorization", "X-Session-Token"],
             methods: %i[get post put patch delete options head],
             credentials: true
    # origins "example.com"
#
#     resource "*",
#       headers: :any,
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
