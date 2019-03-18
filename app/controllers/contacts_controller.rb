class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    render json: Contact.all.as_json
  end

  def show
    render json: @contact.as_json
  end

  def create
    @contact = Contact.create(contact_params)
    if(contact_params[:image])
      @contact.picture = rails_blob_url(@contact.image, host: 'localhost:3000')
      @contact.save
    end
    p @contact
  end

  def update
    @contact.update contact_params
  end

  def destroy
    @contact.destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.permit(
      :id, :name, :phone, :email, :birthday, :note,
      :gender, :city, :street, :postalCode, :province, :tags, :image
    )
    # params.require('contact').permit(
    #   :id, :name, :phone, :email, :birthday, :note,
    #   :gender, :city, :street, :postalCode, :province, :tags
    # )
  end
end
