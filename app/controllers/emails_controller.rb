class EmailsController < ApplicationController
  before_filter :authenticate, :only => [:index,:edit,:update,:destroy]
  respond_to :html, :json
  
  def index
    @emails = current_user.emails
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(params[:email])
    if @email.save
       redirect_to @email, :flash => {:success => "Welcome #{current_user.name}"}
    else
      render 'new'
    end
  end

  def show
    @email = Email.find(params[:id])  
  end

  def edit
     @email = Email.find(params[:id])
  end

  def update
    @email = Email.find(params[:id])
    if @email.update_attributes(params[:email])
      flash[:notice] = "Successfully updated"
       respond_with @user
      #redirect_to @email
    else
      render :action => 'edit'
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to @email
  end

    def  toggled_status
    @email = Email.find(params[:id])
    @email.is_published = !@email.is_published?
    @email.save!
    redirect_to emails_path
  end

   private
   
   def authenticate
     deny_access unless signed_in?
   end
   
 
end
