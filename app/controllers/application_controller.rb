class ApplicationController < ActionController::Base
  def check_valid_ip_address
    if params[:ip].present?
      @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
      if !(params[:ip] =~ @ip_regex)
        render json: {error: "InvalidInput", ip: params[:ip]}, status: :bad_request
      end
    else
      render json: {error: "NoIPAddress", ip: "No IP address"}, status: :bad_request
    end
  end
end
