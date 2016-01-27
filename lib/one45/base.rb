module One45
  class Base

    def self.list(options = {})
      One45.get resource_url, options
    end

    def self.find(id)
      url = "#{resource_url}/#{id}"
      One45.get url
    end

  end
end
