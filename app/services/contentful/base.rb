module Contentful
  module Base
  	DEFAULT_OPTIONS = {
      content_type: 'recipe',
      include: 1
    }.freeze

    def client
      @client ||= Contentful::Client.new(
        access_token: ENV['CONTENTFUL_TOKEN'],
        space: ENV['CONTENTFUL_SPACE'],
        environment: ENV['CONTENTFUL_ENVIRONMENT']
      )
    end
  end
end
