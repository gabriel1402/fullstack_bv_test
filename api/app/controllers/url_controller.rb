class UrlController < ApplicationController

  def create
    url = params[:url]
    old_url = Url.find_by url: url
    if old_url
      render json: {
        status: :success,
        data: old_url.short_url
      }
      return
    end
    new_url = Url.create(permitted_params)
    if new_url.save
      StoreUrlTitleJob.perform_later new_url.id
      return render json: {
        status: :success,
        data: new_url.short_url
      }
    end
    
    render json: {
      status: 400,
      error: new_url.errors.messages
    }, status: :bad_request
    
  end

  def redirect
    url = Url.decode_short_url(params[:id])
    IncrementUrlVisitsJob.perform_later url.id
    redirect_to url.url
  end

  def top_100
    render json: {
      status: :success,
      data: Url::top_100
    }
  end

  private 

  def permitted_params
    params.permit(:url)
  end

end
