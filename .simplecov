SimpleCov.start do
    enable_coverage :branch
    add_filter "rails_helper"
    add_filter "web_steps"
    add_filter "features/support"
    add_filter "features/step_definitions"
    add_filter "config/initializers"
    add_filter "application_controller"
end