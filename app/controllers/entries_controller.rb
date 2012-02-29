class EntriesController < ApplicationController
  before_filter :find_current_category

  attr_accessor :current_category

  def index
    @entries = current_category.entries.all
  end

  def show
    @entry = current_category.entries.find(params[:id])
  end

  def edit
    @entry = current_category.entries.find(params[:id])
  end

  def new
    @entry = current_category.entries.new
  end

  def create
  end
  
  def update
  end

  def destroy
    current_category.entries.find(params[:id]).destroy
  end

  protected

  def find_current_category
    self.current_category = Category.find_by_number(params[:category_number])
    unless self.current_category
      raise "Can not find a Category with the number #{params[:category_number]}"
    end
  end
end