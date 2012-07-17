require 'httparty'

class TravisHook < ServiceHooks::Base
  # Should return a badge url from the service provider
  def badge_url
    "https://secure.travis-ci.org/#{identifier}.png"
  end
  
  # Should return the raw project details from the service provider
  def details
    data()
  end 
  
  # Should return a url with human readable details (github page, rubygems details page, etc.)
  def human_url
    return "http://travis-ci.org/#!/#{data()['slug']}"
  end
  
  # Should return a human status (good or bad)
  def human_status
    raise NotImplementedError
  end 
  
  # Should load the data from the service provider into @data
  def load_data
    data = HTTParty.get("http://travis-ci.org/#{identifier}.json")
  end  
  
  # Should refresh remote data from the service provider
  def refresh_data
    raise NotImplementedError
  end
end

