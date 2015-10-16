class SeedsController < ApplicationController
  include SeedsHelper
  include NearbyHelper
  skip_before_filter :verify_authenticity_token 
	before_action :init_api

	def new
	end

	def create
	end


=begin
  Request Format:
  {
    "user" : 1,
    "loc" : "POINT(70.0001,9.99999)",
    "ne" : "POINT(71,11)",
    "sw" : "POINT(69,9)"
  }
=end
	def nearby
		#resp, status = @api.nearby_seeds(params)
    user_id=params[:user_id]
    my_loc=params[:loc]
    bounds_ne=params[:ne]
    bounds_sw=params[:sw]
    resp,status=nearby_seeds(user_id,my_loc,bounds_ne,bounds_sw)
    process_response(resp, status, params)
	end

  def like
    Seed.find_by(id:params[:seed_id]).yay
    render :json => {:message => "Yay!"}, :status => :ok
  end

  def dislike
    Seed.find_by(id:params[:seed_id]).nay
    render :json => {:message => "Nay!"}, :status => :ok
  end

	private
	def process_response response, status, params
      if status == 200
        render json: response, status: status, callback: params[:callback]
      elsif status == 500
        raise response
      else
        handle_logging(response, status, params)
        render json: RESPONSE[status], status: status, callback: params[:callback]
      end
    end

  def log_file(file_name = "Polygon")
    file_str = File.join "#{Rails.root}","log", "#{file_name}.log"
    File.new(file_str,"w") unless File.exists?(file_str)
    log_file = Logger.new(file_str)
    log_file
  end

  def handle_logging response, status, params
    action = params["action"]
    log_file.error "#{action} || #{status} || #{response} || #{params.except!("controller","action")}"
  end

  def init_api # :nodoc:
  end
end
