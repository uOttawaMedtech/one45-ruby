module One45
  class Events < Base

    def self.academic_half_day_events(options = {})
      url = "#{resource_url}/ahd"
      One45.get url
    end
    singleton_class.send(:alias_method, :ahd_events, :academic_half_day_events)

    def self.academic_half_day_event(id)
      url = "#{resource_url}/ahd/#{id}"
      One45.get url
    end
    singleton_class.send(:alias_method, :ahd_event, :academic_half_day_event)

    def self.academic_half_day_attendees(id)
      url = "#{resource_url}/ahd/#{id}/attendees"
      One45.get url
    end
    singleton_class.send(:alias_method, :ahd_attendees, :academic_half_day_attendees)

    def self.curriculum_events(options = {})
      url = "#{resource_url}/curriculum"
      One45.get url
    end

    def self.curriculum_event(id)
      url = "#{resource_url}/curriculum/#{id}"
      One45.get url
    end

    def self.curriculum_event_attendees(id)
      url = "#{resource_url}/curriculum/#{id}/attendees"
      One45.get url
    end

    def self.curriculum_event_children(id)
      url = "#{resource_url}/curriculum/#{id}/children"
      One45.get url
    end

    def self.rotation_events(options = {})
      url = "#{resource_url}/rotation"
      One45.get url
    end

    def self.rotation_event(id)
      url = "#{resource_url}/rotation/#{id}"
      One45.get url
    end

    def self.rotation_attendees(id)
      url = "#{resource_url}/rotation/#{id}/attendees"
      One45.get url
    end

    private

      def self.resource_url
        "events"
      end

  end
end
