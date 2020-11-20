class Api::V1::MessagesController < Api::V1::ApiController
  def show
    render json: resource
  end

  def create
    message = Message.new(message_params)

    if message.save
      render json: {link: "#{request.origin}/message/#{message.uuid}"}
    else
      render json: {errors: message.errors}, status: 400
    end
  end

  def view_decrypted
    render json: resource, password: params[:password]
  end

  private

  def message_params
    params.require(:message).permit(:text, :password)
  end

  def resource
    message = Message.find_by(uuid: params[:uuid])
    raise ActiveRecord::RecordNotFound if message.nil?
    message
  end
end
