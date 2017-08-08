class Clean

  require 'bundler/setup'
  require 'open-uri'
  require 'uri'
  require 'net/https'
  require 'nokogiri'
  require 'httparty'
  require 'rubygems'
  require 'pp'

  def initialize
    @COUNTER                  = 0
    @htmlArray                = []
    @doc                      = ""
  end

  def collectHTML
    @htmlFiles = Dir.pwd + '/../_site/**/index.html'
    Dir.glob(@htmlFiles) do |file|
      @htmlArray << file
    end
    return @htmlArray
  end

  def success
    puts 'File successfully created: ' + "\033[32m" + @filename + " \033[0m\n"
    hr
  end

  def cleanIMGSRC

    @doc.css('img').each { |img|
      imgSRC = img.attr('src')
      case
        when imgSRC.start_with?('http:')
          puts "\033[32m" + 'Image SRC HTTPS fix' + " \033[0m\n"
          newSRC = imgSRC.sub(/http/, 'https')
          p img.set_attribute('src', newSRC)
        when imgSRC.start_with?('https:', '/assets')
          #p 'nothing to do here'
        else
          puts "\033[32m" + 'Image NEW SRC fix' + " \033[0m\n"
          prefix = 'https://raw.githubusercontent.com/' + @projectName + '/master/'
          p img.set_attribute('src', prefix + imgSRC)
      end
    }

  end

  def cleanIMGALT

    projectName = @projectName.split('/')

    @doc.css('img').each { |img|
      imgALT = img.attr('alt')
      case
        when imgALT.nil?, imgALT.empty?
          puts "\033[32m" + 'Image ALT fix' + " \033[0m\n"
          newALT = projectName[0] + ' by ' + projectName[1]
          p img.set_attribute('alt', newALT)
        else
          #p 'nothing to do here, it has proper alt tag'
      end
    }

  end

  def cleanAHREF

    @doc.css('a').each { |a|
      aHREF = a.attr('href')
      case
        when aHREF.nil?
          #p 'nothing to do here, it is an anchor'
        when aHREF.empty?
          #p 'nothing to do here, it is an anchor'
        when aHREF.start_with?('https', '/assets', '/tag', '/library', 'category', '#')
          #p 'nothing to do here'
        when aHREF == '/'
          #p 'nothing to do here'
        when aHREF.start_with?('mailto')
          #p 'nothing to do here', it is a mailto
        when aHREF.start_with?('page', 'index', '/page')
          #p 'nothing to do here', it is a mailto
        when aHREF.start_with?('http:')
          puts "\033[32m" + 'A HREF HTTPS fix' + " \033[0m\n"
          newHREF = aHREF.sub(/http/, 'https')
          p a.set_attribute('href', newHREF)
        else
          puts "\033[32m" + 'A HREF RELATIVE PATH fix' + " \033[0m\n"
          prefix = 'https://github.com/' + @projectName + '/tree/master/'
          p a.set_attribute('href', prefix + aHREF)
      end
    }

  end

  def cleanHTML
    system("clear")
    collectHTML

    @htmlArray.each do |htmlURL|
      @doc = File.open(htmlURL) { |f| Nokogiri::HTML(f) }
      @projectName = @doc.css('.project').text.delete(' ')
      puts "\033[31m" + @projectName + "\033[0m\n"

      cleanIMGSRC
      cleanIMGALT
      cleanAHREF

      puts @COUNTER +=1
      File.write(htmlURL, @doc.to_html)
    end
  end

end

cleanSite = Clean.new
cleanSite.cleanHTML()
