module ShoppingMall
  class Escalator
    attr_reader :app, :escalator

    def initialize(app)
      @app = app
      @escalator = _escalator_factory app
    end

    def call(env)
      escalator.call env
    end

    private

    def _escalator_factory(app)
      ShoppingMall.escalator_class.new app
    end
  end
end
