require 'httparty'

class GithubHook < ServiceHooks::Base
  # Should return a badge url from the service provider
  def badge_url
    raise NotImplementedError
  end
  
  # Should return the raw project details from the service provider
  def details
    data()
  end    
  
  # Should return a url with human readable details (github page, rubygems details page, etc.)
  def human_url
    data()['html_url']
  end
  
  # Should return a human status (good or bad)
  def human_status
    raise NotImplementedError
  end 
  
  # Should load the data from the service provider into @data
  def load_data
    data = HTTParty.get("https://api.github.com/repos/#{identifier}")
  end  
  
  # Should return the readme file from github
  def readme(branch = 'master')
    HTTParty.get("https://raw.github.com/#{identifier}/#{branch}/README.rdoc").body
  end
  
  # Should refresh remote data from the service provider
  def refresh_data
    raise NotImplementedError
  end
end

