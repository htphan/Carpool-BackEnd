class MedicalsController < ApplicationController
  before_action :authenticate_with_token!, except: [:create]

  def show
    @child = Child.find_by(id: params[:id])
    @medical = @child.medical

    if @medical
      render partial: 'medical', status: :ok
    else
      render json: { message: "No medical information found." }, status: :no_content
    end
  end

  def create
    attributes = {
      conditions: params[:conditions],
      medications: params[:medications],
      notes: params[:notes],
      allergies: params[:allergies],
      insurance: params[:insurance],
      religious_preference: params[:religious_preference]
    }
    if params[:child_id]
      @child = Child.find_by(id: params[:child_id])

    else
      @child = Child.where("user_id = ? AND first_name = ? AND last_name = ?", 
                            current_user.id, params[:first_name], params[:last_name]).first
    end
    @medical = Medical.new(attributes)
    @medical.child_id = @child.id

    if @medical.save
      render json: @medical, except: [:created_at, :updated_at], status: :created
    else
      render json: { errors: @medical.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    attributes = {
      conditions: params[:conditions],
      medications: params[:medications],
      notes: params[:notes],
      allergies: params[:allergies],
      insurance: params[:insurance],
      religious_preference: params[:religious_preference]
    }
    @child = Child.find_by(id: params[:id])
    if current_user.access_token == @child.user.access_token
      @medical = @child.medical
      @medical.update(attributes)
      render json: @medical, except: [:created_at, :updated_at], status: :ok
    else
      render json: { message: "Unauthorized to modify this medical information." }, status: :unauthorized
    end
  end

  def delete
    @child = Child.find_by(id: params[:id])
    @medical = @child.medical
    if current_user.access_token == @child.user.access_token
      @medical.destroy
      render json: { message: "Medical Information deleted."}, status: :no_content
    else
      render json: { message: "Unauthorized to delete this medical information." }, status: :unauthorized
    end
  end

end
