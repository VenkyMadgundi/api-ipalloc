class DevicesController < ApplicationController
  before_filter :check_valid_ip_address, only: [:index]
  def index
    if ENV['IPALLOC_DATAPATH']
      device = ""
      File.open("#{ENV["IPALLOC_DATAPATH"]}",'r') do |file|
        file.each_line do |line|
          item = line.split(",")
          if item[1].strip == params[:ip].strip && item[2].strip == params[:device].strip
            device = item[2]       
            break
          end
        end
      end

      if(device.length > 0)
        render json: {device: params[:device], ip: params[:ip] }, status: :ok 
      else
        render json: {error: "NotFound", ip: params[:ip]}, status: :not_found
      end
    else
      render json: {error: "Please Set 'IPALLOC_DATAPATH' environment variable"}, status: :bad_request
    end


  end
end
