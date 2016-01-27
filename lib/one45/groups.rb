module One45
  class Groups < Base

    def self.subgroups(id)
      url = "#{resource_url}/#{id}/children"
      One45.get url
    end

    private

      def self.resource_url
        "groups"
      end

  end
end
