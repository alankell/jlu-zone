class Community::CommunityController < ApplicationController
  include Wiki::Controllers::Sidebar::CommunitySidebar
  include Wiki::Controllers::TabsHighLight::Base
  include Wiki::Controllers::TabsHighLight::Community
  def index
    @topics = Topic.order("updated_at desc").all.paginate(:page => params[:page], :per_page => 10)
    drop_breadcrumb(itext("navigation.community"), community_path)
    drop_breadcrumb(itext("topic.active_topic"), community_path)
    #drop_breadcrumb(current_category.name)
    render "community/index"
  end
end