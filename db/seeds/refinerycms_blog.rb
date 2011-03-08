#if ActorPlugin.where(:name => "refinerycms_blog").first.nil?
#  Administrator.find(:all).each do |user|
#    user.plugins.create(:name => "refinerycms_blog",
#                        :position => (user.plugins.maximum(:position) || -1) +1)
#  end

  page = Page.create(
    :title => "Blog",
    :link_url => "/blog",
    :deletable => false,
    :position => ((Page.where(:parent_id => nil).desc(:position).first.position || -1)+1),
    :menu_match => "^/blogs?(\/|\/.+?|)$"
  )
#Page.maximum(:position, :conditions => {:parent_id => nil})


  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
#end

