class SeedsController < ApplicationController
  include SeedsHelper
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
    user_id=params[:user]
    my_loc=params[:loc]
    bounds_ne=params[:ne]
    bounds_sw=params[:sw]
    resp,status=nearby_seeds(user_id,my_loc,bounds_ne,bounds_sw)
    process_response(resp, status, params)
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

    def init_api # :nodoc:

    end
end
