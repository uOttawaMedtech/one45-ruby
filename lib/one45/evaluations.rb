module One45
  class Evaluations < Base

    def self.answers(id)
      url = "#{resource_url}/#{id}/answers"
      One45.get url
    end

    def self.contributors(id)
      url = "#{resource_url}/#{id}/contributors"
      One45.get url
    end

    def self.question_answers(id, question_id)
      url = "#{resource_url}/#{id}/question/#{question_id}/answer"
      One45.get url
    end

    private

      def self.resource_url
        "evaluations"
      end

  end
end
