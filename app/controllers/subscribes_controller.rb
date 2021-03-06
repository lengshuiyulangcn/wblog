class SubscribesController < ApplicationController
  def index
  end
  def create
    subscribe = Subscribe.find_or_initialize_by(email: params[:email])
    subscribe.enable = true

    if subscribe.save
      render :json => { success: true }
    else
      render :json => { success: false, message: subscribe.errors.full_messages.join(", ")}
    end
  end

  def cancel
    if subscribe = Subscribe.where(email: params[:email]).first
      subscribe.enable = false
      subscribe.save
    end

    flash[:notice] = "退订成功: #{params[:email]}"
    render :json => { success: true }
  end

end
