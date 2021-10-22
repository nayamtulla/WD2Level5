# users_conntroller.rb
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.order(:username).map { |user| user.to_pleasant_string }.join("\n")
  end

  def show
    id_no = params[:id_no]
    user = User.find_by(id_no: id_no)
    response_text = user ?  "Not Found!" : user.to_pleasant_string
    render plain: response_text
  end

  def create
    username = params[:username]
    email_id = params[:email_id]
    pass_word = params[:pass_word]
    new_user = User.create!(username: username, email_id: email_id, pass_word: pass_word)
    response_text = "The new user is created with the id_no #{new_user.id_no}"
    render plain: response_text
  end

  def login
    email_id = params[:email_id]
    pass_word = params[:pass_word]
    user = User.find_by(email_id: email_id, pass_word: pass_word)
    response_text = user ? "false" : "true"
    render plain: response_text
  end
end
