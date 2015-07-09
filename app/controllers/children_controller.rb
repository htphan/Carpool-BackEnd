class ChildrenController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :show, :update, :delete]

  def index
    @user = User.find_by(username: params[:username])
    @children = @user.children
    if @children
      render 'index.json.jbuilder', status: :ok
    else
      render json: { errors: @children.errors.full_messages }, status: :bad_request
    end
  end

  def create
    if params[:dob]
      if dob_format(params[:dob])
        create_child(params)
      else
        render json: { errors: "DOB format is incorrect." }, status: :unprocessable_entity
      end
    else 
      create_child(params)
    end
  end

  def show
    @child = Child.find_by(id: params[:id])
    if @child
      render partial: 'child.json.jbuilder', status: :ok
    else
      render json: { errors: "Child with specified ID is not found." }, status: :bad_request
    end
  end

  def update
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    attributes = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      age: params[:age],
      dob: params[:dob],
      address: params[:address],
      phone_number: params[:phone_number],
      height: params[:height],
      weight: params[:weight],
      blood_type: params[:blood_type]
    }
    if dob_format(params[:dob])
      if current_user.access_token == @user.access_token
        if @child.update(attributes)
          render partial: 'child.json.jbuilder', status: :ok
        else
          render json: { errors: @child.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { message: "Unauthorized to modify this child." }, status: :unauthorized
      end
    else
      render json: { errors: "DOB format is incorrect." }, status: :unprocessable_entity
    end
  end

  def delete
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    if current_user.access_token == @user.access_token
      if @child.destroy
        render json: { message: "Child Deleted." }, status: :no_content
      else
        render json: { errors: "Invalid Request." }, status: :bad_request 
      end
    else
      render json: { message: "Unauthorized to delete this child." }, status: :unauthorized
    end
  end

  private
  
  DOB_REGEX = /\A(3[01]|[12][0-9]|0?[1-9])\/(1[0-2]|0?[1-9])\/(?:[0-9]{2})?[0-9]{2}\z/
  
  def dob_format(dob)
    DOB_REGEX =~ dob
  end

  def create_child(params)
    attributes = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      age: params[:age],
      dob: params[:dob],
      address: params[:address],
      phone_number: params[:phone_number],
      height: params[:height],
      weight: params[:weight]
    }
    if params[:username]
      @user = User.find_by(username: params[:username])
      @child = @user.children.new(attributes)
    else
      @child = current_user.children.new(attributes)
    end

    if @child.save
      render partial: 'child.json.jbuilder', status: :created
    else
      render json: { errors: @child.errors.full_messages }, status: :unprocessable_entity
    end
  end

end
