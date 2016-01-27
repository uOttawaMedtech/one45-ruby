module One45
  class Forms < Base

    def self.groups(id)
      url = "#{resource_url}/#{id}/groups"
      One45.get url
    end

    def self.questions(id)
      url = "#{resource_url}/#{id}/questions"
      One45.get url
    end

    private

      def self.resource_url
        "forms"
      end

  end
end
