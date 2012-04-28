# -*- coding: utf-8 -*-

class UsersController < ApplicationController


  # Only allow a logged-in users to view & update their accounts
  before_filter :authenticate_user!, :only => [:show, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user]) # create user record
    if @user.save
      
      @profile = @user.profile.new # just empty profile to begin with
      pp @profile
      puts 'rendering new_profile template'
      render 'new_profile', :notice => "Signed up!" and return      
    else
      render "new"
    end
  end

  def show
    @user = current_user    
  end


end
