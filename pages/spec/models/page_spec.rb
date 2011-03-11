require 'spec_helper'

describe PagePart do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:title).of_type(String) }
  it { should have_field(:body).of_type(String) }
  it { should have_field(:position).of_type(Integer) }
  it { should validate_presence_of(:title) }
  it { should be_embedded_in(:page).as_inverse_of(:parts) }

end

describe Page do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:title).of_type(String) }
  it { should have_field(:parent_id).of_type(Object) }
  it { should have_field(:position).of_type(Integer) }
  it { should have_field(:path).of_type(String) }
  it { should have_field(:meta_keywords).of_type(String) }
  it { should have_field(:meta_description).of_type(String) }
  it { should have_field(:show_in_menu).of_type(Boolean).with_default_value_of(true) }
  it { should have_field(:link_url).of_type(String) }
  it { should have_field(:menu_match).of_type(String) }
  it { should have_field(:deletable).of_type(Boolean).with_default_value_of(true) }
  it { should have_field(:custom_title).of_type(String) }
  it { should have_field(:custom_title_type).of_type(String).with_default_value_of('none') }
  it { should have_field(:draft).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:browser_title).of_type(String) }
  it { should have_field(:skip_to_first_child).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:lft).of_type(Integer) }
  it { should have_field(:rgt).of_type(Integer) }
  it { should have_field(:depth).of_type(Integer) }
  it { should validate_presence_of(:title) }
  it { should embed_many(:parts) }

  def reset_page(options = {})
    if @page
      @page.destroy!
      @page.children.each(&:destroy!)
      @page = nil
      @child = nil
    end

    @page = Page.create!({
      :id => 1,
      :title => "RSpec is great for testing too",
      :deletable => true
    }.update(options))
  end

  def page_cannot_be_destroyed
    @page.destroy.should == false
  end

  def create_child
    @child = @page.children.create(:title => 'The child page')
  end

  def create_page_parts
    @page.parts.create(:title => 'body', :content => "I'm the first page part for this page.")
    @page.parts.create(:title => 'side body', :content => "Closely followed by the second page part.")
  end

  def turn_off_marketable_urls
    RefinerySetting.set(:use_marketable_urls, {:value => false, :scoping => 'pages'})
  end

  def turn_on_marketable_urls
    RefinerySetting.set(:use_marketable_urls, {:value => true, :scoping => 'pages'})
  end

  before(:each) do
    reset_page
  end

  context "cannot be deleted under certain rules" do
    it "if link_url is present" do
      reset_page({:link_url => '/plugin-name'})
      page_cannot_be_destroyed
    end


    it "if refinery team deems it so" do
      reset_page({:deletable => false})
      page_cannot_be_destroyed
    end

    it "if menu_match is present" do
      reset_page({:menu_match => '^/RSpec is great for testing too.*$'})
      page_cannot_be_destroyed
    end

    it "unless you really want it to! >:]" do
      reset_page
      @page.destroy!
    end
  end

  context "page urls" do

    it "should return a full path" do
      @page.path.should == 'RSpec is great for testing too'
    end

    it "and all of its parent page titles, reversed" do
      create_child
      @child.path.should == 'RSpec is great for testing too - The child page'
    end

    it "or normally ;-)" do
      create_child
      @child.path({:reversed => false}).should == 'The child page - RSpec is great for testing too'
    end

    it "should return its url" do
      @page.link_url = '/contact'
      @page.url.should == '/contact'
    end

    it "should return its path with marketable urls" do
      turn_on_marketable_urls
      @page.url[:id].should be_nil
      @page.url[:path].should == ["rspec-is-great-for-testing-too"]
    end

    it "should return its path underneath its parent with marketable urls" do
      create_child
      @child.url[:id].should be_nil
      @child.url[:path].should == [@page.url[:path].first, 'the-child-page']
    end

    it "should not have a path without marketable urls" do
      turn_off_marketable_urls
      @page.url[:path].should be_nil
      @page.url[:id].should == "rspec-is-great-for-testing-too"
      turn_on_marketable_urls
    end

    it "should not mention its parent without marketable urls" do
      turn_off_marketable_urls
      create_child
      @child.url[:id].should == 'the-child-page'
      @child.url[:path].should be_nil
      turn_on_marketable_urls
    end
  end

  context "home page" do
    it "should respond as the home page" do
      @page.link_url = '/'
      @page.home?.should == true
    end

    it "should not respond as the home page" do
      @page.home?.should == false
    end
  end

  context "content sections (page parts)" do
    it "should return the content when using []" do
      create_page_parts

      @page[:body].should == "<p>I'm the first page part for this page.</p>"
      @page["BoDY"].should == "<p>I'm the first page part for this page.</p>"
    end

    it "should return all page part content" do
      create_page_parts

      @page.all_page_part_content.should == "<p>I'm the first page part for this page.</p> <p>Closely followed by the second page part.</p>"
    end

    it "should reposition correctly" do
      create_page_parts
      @page.parts.first.position = 6
      @page.parts.last.position = 4

      @page.parts.first.position.should == 6
      @page.parts.last.position.should == 4

      @page.reposition_parts!

      @page.parts.first.position.should == 0
      @page.parts.last.position.should == 1
    end
  end

  context "draft pages" do
    it "should not be a live page when set to draft" do
      @page.draft = true
      @page.live?.should == false

      @page.draft = false
      @page.live?.should == true
    end
  end

#  context "should add url suffix" do
#    before(:each) do
#      turn_on_marketable_urls
#      @reserved_word = Page.friendly_id_config.reserved_words.last
#      reset_page(:title => @reserved_word)
#    end

#    it "when title is set to a reserved word" do
#      @page.url[:path].should == ["#{@reserved_word}-page"]
#    end

#    it "when parent page title is set to a reserved word" do
#      create_child.url[:path].should == ["#{@reserved_word}-page", 'the-child-page']
#    end
#  end

end
# {"title"=>"Pickles are Cucumbers Soaked in Evil", "parts_attributes"=>{"0"=>{"title"=>"Body", "body"=>"", "position"=>"0"}, "1"=>{"title"=>"Side Body", "body"=>"", "position"=>"1"}}, "draft"=>"0", "parent_id"=>"", "custom_title_type"=>"none", "custom_title"=>"", "skip_to_first_child"=>"0", "link_url"=>"", "show_in_menu"=>"1", "browser_title"=>"", "meta_keywords"=>"", "meta_description"=>"", "position"=>0}

