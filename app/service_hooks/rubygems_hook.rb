require 'crack'
require 'httparty'

class RubygemsHook < ServiceHooks::Base
  include HTTParty
  
  parser(
    Proc.new do |body, format|
      Crack::JSON.parse(body)
    end
  )
  
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
    return data()['project_uri']
  end
  
  # Should return a human status (good or bad)
  def human_status
    raise NotImplementedError
  end 
  
  # Overload identifier to split
  def identifier=(identifier)
    @identifier = identifier.split("/")[1] 
  end
  
  # Should load the data from the service provider into @data
  def load_data
    data = RubygemsHook.get("https://rubygems.org/api/v1/gems/#{identifier}.json")
  end  
  
  # Should refresh remote data from the service provider
  def refresh_data
    raise NotImplementedError
  end
end

