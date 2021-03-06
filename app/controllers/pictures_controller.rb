# frozen_string_literal: true
class PicturesController < OpenReadController
  before_action :set_picture, only: [:show, :update, :destroy]

  # GET /pictures
  def index
    @pictures = Picture.all

    render json: @pictures
  end

  # GET /pictures/1
  def show
    render json: @picture
  end

  # POST /pictures
  def create
    @picture = current_user.pictures.build(picture_params)

    @existing_pictures = Picture.where(title: @picture.title)
    if @existing_pictures.length > 0
      render json: @existing_pictures[0], status: :created
    elsif @picture.save
      render json: @picture, status: :created
    else
      render json: @picture.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pictures/1
  def update
    if @picture.update(picture_params)
      render json: @picture
    else
      render json: @picture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pictures/1
  def destroy
    @picture.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = current_user.pictures.find(params[:id])
  end
  private :set_picture

  # Only allow a trusted parameter "white list" through.
  def picture_params
    params.require(:picture).permit(:title, :date, :explanation, :hdurl)
  end
  private :picture_params
end
