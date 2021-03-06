class SeedsController < ApplicationController
  include SeedsHelper
  include NearbyHelper
  skip_before_filter :verify_authenticity_token 
	before_action :init_api

=begin
  {
    "user_id": "124",
    "fb_auth_id" : "123",
    "tag_ids" : [123,124],
    "link" : "tattiurl",
    "lat": "20",
    "lng": "70",
    "title": "title",
    "is_public": true,
    "labels" : "happy,sad"
  } 
=end
  def register
    labels=params.has_key?('labels') ? params[:labels] : []
    labels=labels.split(',').map(&:strip) rescue []
    tag_ids=params[:tag_ids].split(',').map(&:strip) rescue []
    resp, status = Seed.register params[:user_id], params[:fb_auth_id], params[:link], tag_ids, params[:lat], params[:lng], params[:title], params[:is_public], labels
    if status == 1
      render :json => {:message => "Saved"}, :status => 200
    else
      render :json => {:message => "Problem"}, :status => 402
    end
  end

=begin
:method: nearby
<b>Author</b> Harman Singh
<b>Common Name</b> Nearby
<b>Short Description</b> Get seeds based on viewport
<b>Endpoints</b> Android
<b>Request Type</b> POST
<b>Route </b> /seed/nearby/
<b>Authentication Required</b> Public
<b>Request Format</b> 
    {
    "user_id" : 1,
    "loc" : "POINT(70.0001 19.99999)",
    "ne" : "POINT(71 21)",
    "sw" : "POINT(69 19)"
  }
<b>Response Format</b> all polygons with initials as input is sent in response
    
=end
	def nearby
    key, value = params.first
    json = JSON.parse key
    user_id=json['user_id']
    my_loc=json['loc']
    bounds_ne=json['ne']
    bounds_sw=json['sw']
    labels=json.has_key?('labels') ? json['labels'] : []

    resp,status=nearby_seeds(user_id,my_loc,bounds_ne,bounds_sw,labels)
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
