

class BrowserEngine
  
  def initialize(world)
    @world = world
  end

  def create_new_browser
    @world.logger.debug "Creating new #{@world.configuration['BROWSER']} Browser"
    case @world.configuration['BROWSER']
      when 'firefox'
        @world.browser = firefox_browser
      when 'internet_explorer'
        @world.browser = internet_explorer_browser
      when 'chrome'
        @world.browser = chrome_browser
      else
        raise "ERROR: No browser specified in configuration!\n" if @world.configuration['BROWSER'].nil?
        raise "ERROR: Browser #{@world.configuration['BROWSER']} is not supported!\n"
    end
    @world.browser.window.maximize if @world.configuration['MAXIMIZE_BROWSER']
  end

  def chrome_browser
    if @world.configuration['USE_GRID']
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_options: {'detach' => true})
      driver = Selenium::WebDriver.for(:remote, :url => @world.configuration['ENVIRONMENT']['GRID'] , desired_capabilities: capabilities)
    else
      options = Selenium::WebDriver::Chrome::Options.new
      if @world.configuration['HEADLESS_CHROME']
        options.add_argument('headless')
      else
        options.add_option(:detach, true)
      end

      if OS.linux?
        path = "#{@world.configuration['CORE_DIR']}/utils/web_drivers/linux-chromedriver"
      else
        path = "#{@world.configuration['CORE_DIR']}/utils/web_drivers/chromedriver"
        path += '.exe' if OS.windows?
      end      
      driver = Selenium::WebDriver.for(:chrome, options: options, driver_path: path)
    end
    return Watir::Browser.new(driver)
  end

  def internet_explorer_browser
    @world.logger.debug 'Running internet_explorer_protected_mode.bat...'
    system("#{@world.configuration['CORE_DIR']}/utils/web_drivers/internet_explorer_protected_mode.bat")

    Selenium::WebDriver::IE.driver_path = "#{@world.configuration['CORE_DIR']}/utils/web_drivers/IEDriverServer.exe"
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds
    driver = Selenium::WebDriver.for(:ie, :http_client => client)

    return Watir::Browser.new(driver)
  end

  def firefox_browser
    path = "#{@world.configuration['CORE_DIR']}/utils/web_drivers/geckodriver"
    return Watir::Browser.new(:firefox, driver_path: path)
  end

end
