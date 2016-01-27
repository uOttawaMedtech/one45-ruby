module One45
  class Users < Base

    def self.preferences(id)
      url = "#{resource_url}/#{id}/preferences"
      One45.get url
    end

    def self.todos(id, options = {})
      url = "#{resource_url}/#{id}/todos"
      One45.get url
    end

    def self.evaluations(id, options = {})
      url = "#{resource_url}/#{id}/todos/evaluations"
      One45.get url
    end

    private

      def self.resource_url
        "people"
      end
  end
end
