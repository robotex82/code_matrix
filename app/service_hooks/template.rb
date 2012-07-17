class TemplateHook < ServiceHooks::Base
    # Should return a badge url from the service provider
    def badge_url
      raise NotImplementedError
    end
    
    # Should return the raw project details from the service provider
    def details
      raise NotImplementedError
    end
    
    # Should return a url with human readable details (github page, rubygems details page, etc.)
    def human_url
      raise NotImplementedError
    end
    
    # Should return a human status (good or bad)
    def human_status
      raise NotImplementedError
    end   
    
    # Should load the data from the service provider into @data
    def load_data
      raise NotImplementedError
    end    
    
    # Should refresh remote data from the service provider
    def refresh_data
      raise NotImplementedError
    end
end

