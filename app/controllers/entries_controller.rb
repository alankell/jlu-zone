class EntriesController < ApplicationController
  before_filter :authenticate_user!,    :except => [:show, :index]
  before_filter :find_current_category, :only   => [:show, :index]

  attr_accessor :current_category
  
  helper_method :current_category

  def index
    @entries = current_category.entries.all
  end

  def show
    @entry = current_category.entries.find(params[:id])
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.create_entry(model_params, current_user)
    if @entry.save
      redirect_to_as_create_success [current_category, @entry]
    else
      render_as_create_fail "entries/new"
    end
  end
  
    def update
    @entry = Entry.find(params[:id])
    if @entry.update_entry(model_params, current_user)
      redirect_to_as_update_success [current_category, @entry]
    else
      render_as_update_fail "entries/edit"
    end
  end

  def destroy
    Entry.find(params[:id]).destroy
  end

  protected

  def find_current_category
    return nil unless params[:category_number]
    self.current_category = Category.find_by_number(params[:category_number])
    unless self.current_category
      raise "Can not find a Category with the number #{params[:category_number]}"
    end
  end
end