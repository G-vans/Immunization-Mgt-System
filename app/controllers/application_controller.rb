class ApplicationController < ActionController::Base
    before_action :authenticate_medic!
end
