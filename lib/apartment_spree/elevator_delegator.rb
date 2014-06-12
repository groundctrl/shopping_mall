module ApartmentSpree
  class ElevatorDelegator
    attr_reader :app, :elevator

    def initialize(app)
      @app = app
      @elevator = _elevator_factory app
    end

    def call(env)
      elevator.call env
    end

    private

    def _elevator_factory(app)
      ApartmentSpree.elevator_class.new app
    end
  end
end
