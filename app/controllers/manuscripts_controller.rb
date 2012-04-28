class ManuscriptsController < ApplicationController
 
  before_filter :authenticate_user!
  
  def index
    @manuscripts = current_user.manuscripts if current_user
  end

  # Form for user to submit a new MS
  def new


    # Direct user to ORCID registration prompt before submitting MS
    if params[:register_orcid]
      # store destination in session? 
      redirect_to users_register_orcid_path(:destination => new_manuscript_path) and return # ToDo: add destination=current URL
    end

    # Otherwise go straight to form to submit MS
    @manuscript = current_user.manuscripts.new
    render
  end

  # Create new MS from user-supplied params
  def create
    @manuscript = current_user.manuscripts.new(params[:manuscript])
    if @manuscript.save
      redirect_to(manuscripts_path, :notice => 'Manuscript '+@manuscript.title+' was successfully submitted.')
    else
      render :action => "new"
    end
  end

  # Form for editing an existing MS
  def edit
    @manuscript = Manuscript.find params[:id]
  end

  def show
    @manuscript = Manuscript.find params[:id]
  end


  def destroy
    @manuscript = Manuscript.find params[:id]
    @manuscript.destroy    
    flash[:notice] = "Successfully destroyed manuscript."
    redirect_to manuscripts_url
  end


end
