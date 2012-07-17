class Project < ActiveRecord::Base
  # Acts as markup
  acts_as_rdoc :github_readme
  
  # Attributes
  attr_accessor :github_hook, :rubygems_hook, :travis_hook
  attr_accessible :github_name
  
  # Callbacks
  after_initialize :load_hooks
  
  # Delegates
  delegate :details, 
           :human_url, 
           :readme, 
           :to => :github_hook, 
           :prefix => :github
  
  delegate :details, 
           :human_url, 
           :to => :rubygems_hook, 
           :prefix => :rubygems  
  
  delegate :badge_url,
           :details, 
           :human_url, 
           :to => :travis_hook, 
           :prefix => :travis
  
  # Public methods
  
  def github_owner
    github_name.split("/")[0]
  end
  
  def github_project
    github_name.split("/")[1]
  end  
  
  # Private methods
  private
  
  def load_hooks
    @github_hook = GithubHook.new(self.github_name)
    @rubygems_hook = RubygemsHook.new(self.github_name)
    @travis_hook = TravisHook.new(self.github_name)
  end
  
#  def github_details
#    @github_details ||= HTTParty.get("https://api.github.com/repos/#{github_name}")
#  end 
#  
#  def github_html_url
#    #return self.github_details[:url] if self.github_details.respond_to?(:url)
#    return self.github_details['html_url']
#  end
#  
#  def readme
#    HTTParty.get("https://raw.github.com/#{github_name}/master/README.rdoc")
#  end 
#  
#  def rubygems_details
#    @rubygems_details ||= HTTParty.get("https://rubygems.org/api/v1/gems/#{github_project}.json")
#  end
#  
#  def rubygems_html_url
#    return self.rubygems_details['project_uri'] rescue nil
#  end
#  
#  
#  def travis_ci_details
#    @travis_ci_details ||= HTTParty.get("http://travis-ci.org/#{github_name}.json")
#  end
#  
#  def travis_ci_html_url
#    return "http://travis-ci.org/#!/#{self.travis_ci_details['slug']}" rescue nil
#  end  
end
