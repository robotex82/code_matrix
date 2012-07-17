module ServiceHooks
  class Base
    # Holds the data from the service provider
    attr_accessor :data
    
    # project identifier
    attr_accessor :identifier
    
    # constructor
    def initialize(identifier)
      self.identifier = identifier
      @data = nil
    end
    
    # Should return a badge from the service provider
    def badge
      raise NotImplementedError
    end
    
    # reuturns the loaded data or loads the data from the service provider if data is nil.
    def data
      @data ||= load_data
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
end
