module FormHelper
  
  # show_model_form @customer do |form|
  #   form.show_text_input            :name
  #   form.show_email_input           :email
  #   form.show_password_input        :password
  # end
  #

  def show_model_form(models, options ={}, &block)
    puts models
    puts options.size
    models = Array.wrap(models)
    options.merge!(:builder => Wiki::Builders::ModelFormBuilder)
    self.form_for(models, options) do |form|
      self.html_contents do |contents|
        contents << self.model_error_messages(models.last)
        contents << capture(form, &block)
      end
    end
  end
  
  def model_error_messages(object)
    messages = object.errors.messages.map do |key, value|
      value
    end
    messages.flatten!
    return if messages.empty?

    contents_tag(:div, :class => "alert alert-error") do |contents|
      contents << content_tag(:a, '&times'.html_safe, :class=>'close' , "data-dismiss" => :alert)
      contents << content_tag(:strong, flash[:error], :class => "alert-heading") if flash[:error]
      contents << content_tag(:ul) do
        list_items = messages.map do |msg|
          content_tag(:li, msg)
        end
        list_items.join.html_safe
      end
    end
  end
    
end