class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :phone_number << :company_name << :first_name << :last_name
=begin
    devise_parameter_sanitizer.for(:account_update) << :phone_number << :company_name << :first_name << :last_name <<
        :gender << :smoker << :language_spoken << :pets << :bed_before_11pm << :wake_before_9am << :music_often <<
        :visitors_often << :social << :smoker_accepted << :pets_accepted << :bed_before_11pm_accepted <<
        :wake_before_9am_accepted << :music_often_accepted << :visitors_often_accepted << :social_accepted
=end
=begin
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,
        :phone_number , :company_name , :first_name , :last_name , :gender , :smoker , :language_spoken , :pets ,
        :bed_before_11pm , :wake_before_9am , :music_often , :visitors_often , :social , :smoker_accepted ,
        :pets_accepted , { bed_before_11pm_accepted: [] }, { wake_before_9am_accepted: [] }, { music_often_accepted: [] },
        { visitors_often_accepted: [] }, { social_accepted: [] }, :survey_completed) }
=end

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,
       :phone_number , :company_name , :first_name , :last_name , :gender , :smoker , :language_spoken , :pets ,
       :bed_before_11pm , :wake_before_9am , :music_often , :visitors_often , :social , :smoker_accepted ,
       :pets_accepted , :bed_before_11pm_accepted, :wake_before_9am_accepted, :music_often_accepted,
       :visitors_often_accepted, :social_accepted, :survey_completed) }

  end
end
