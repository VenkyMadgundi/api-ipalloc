#require 'fileutils'
class AddressesController < ApplicationController
  before_filter :check_valid_ip_address, only: [:assign]

  def assign
    if ENV['IPALLOC_DATAPATH']
      entry_not_exists = true
      File.open("#{ENV["IPALLOC_DATAPATH"]}",'r') do |file|
        file.each_line do |line|
          item = line.split(",")
          entry_not_exists = false if item[1].strip == params[:ip].strip && item[2].strip == params[:device].strip
        end
      end

      if entry_not_exists
        tempfile = File.open("#{ENV["IPALLOC_DATAPATH"]}", 'a')
        tempfile << "1.2.0.0/16,#{params[:ip]},#{params[:device]}\n"
        tempfile.close
        render json: {ip: params[:ip], device: params[:device]}, status: :created
      else
        render json: {error: "AlreadyAssigned", ip: params[:ip], device: params[:device]}, status: :conflict
      end
    else
      render json: {error: "Please Set 'IPALLOC_DATAPATH' environment variable"}, status: :bad_request
    end
  end
end
