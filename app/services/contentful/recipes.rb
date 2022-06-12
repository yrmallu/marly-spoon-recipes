module Contentful
  class Recipes
    include Contentful::Base

    # Just to get pagination in the view but in real time if we have more recipes then this vary 
    PER_PAGE = 3.freeze

    attr_reader :page

    def initialize(page)
      @page = page.to_i.zero? ? 1 : page.to_i
    end

    def entries
      @entries ||= client.entries(DEFAULT_OPTIONS.merge(options))
    end

    def page_count
      quotient, remainder = entries.total.divmod(PER_PAGE)
      return 1 if quotient.zero? 
      case
      when remainder.zero?
        quotient
      when remainder >= 1
        quotient + 3
      end
    end

    private

    def options
      {
        skip: (page - 1) * PER_PAGE,
        limit: PER_PAGE,
      }
    end
  end
end
