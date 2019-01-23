class UrlController < ApplicationController
  include Base62_Helper

  def create
    url = params[:url]
    old_url = Url.find_by url: url
    if old_url
      render json: {
        status: :success,
        data: 'localhost:3000/' + encode(old_url.id)
      }
      return
    end
    new_url = Url.create(permitted_params)
    if new_url.save
      StoreUrlTitleJob.perform_later new_url.id
      return render json: {
        status: :success,
        data: 'localhost:3000/' + encode(new_url.id)
      }
    end
    
    render json: {
      status: 400,
      error: new_url.errors.messages
    }, status: :bad_request
    
  end

  def redirect
    id = decode(params[:id])
    url = Url.find(id)
    redirect_to url.url
  end

  private 

  def permitted_params
    params.permit(:url)
  end

end
