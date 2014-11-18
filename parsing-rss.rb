#!/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'nokogiri'

def createHTML (myRss, nextPage)
  
    puts "#{myRss}, #{nextPage}"
  
  rss = Nokogiri::XML(open("http://estaticos.elmundo.es/elmundodeporte/rss/#{myRss}.xml"))
  # check for parsing errors...
  puts "Errors exist" if (rss.errors.any?)

  myfile = "/Users/Leo/Sites/Demo-Scrolling-Ads/#{myRss}.html"
        #myfile = "/home/ubuntu/www/Demo-Scrolling-Ads/#{myRss}.html"


  File.open("#{myfile}", "w") do |f2|
    header = rss.at_css('channel title').text
    headerh1 = header.split("//")[0]
    headerSmall = header.split("//")[1]
    if myRss == 'portada'
      f2.puts "<div id='#{myRss}' class='page-header'><h1>#{headerh1}</h1></div>"
    else
       f2.puts "<div id='#{myRss}' class='page-header'><h2>#{headerh1}</h2></div>"
     end
    f2.puts "<ul class='flex-container'>"
    rss.search('item').map do |i|
      if myRss == 'portada'
        f2.puts "<li class='flex-item'>"
      else
        f2.puts "<li class='flex-item flex-item2'>"
      end
      thumbnail = i.at('media|content')
      begin
        foto = thumbnail['url']
      rescue
        foto = ''
      end
    
      fotoTitle =  i.at('media|title').text
      title =  i.search('title').text
      link = i.search('link').text
      pubdate = i.search('pubDate').text
      pubdate = pubdate[0, 17]
      description = i.search('description').text
      description1 = description[0, 100]
      author = i.at('dc|creator').text
      if foto != ''
        f2.puts "<a href='#{link}' class='thumbnail'><img class='img-responsive' data-src='holder.js/100%x60' src='#{foto}' alt='#{fotoTitle}' width='100%' /></a>" 
      end
      if myRss == 'portada'
        f2.puts "<h3><a href='#{link}'>#{title}</a> <br><small class='text-muted'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> #{author} | #{pubdate}</small></h3>"
        f2.puts "<p class='lead'>#{description1}</p>"
      else
        f2.puts "<h4><a href='#{link}'>#{title}</a><br><small class='text-muted'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> #{author} |  #{pubdate}</small></h4>"
        f2.puts "<p class='lead low'>#{description}</p>"
      end
      
    
      f2.puts "</li>"

    end
    f2.puts "</ul>"
    
    f2.puts "<div class='ads'><img class='img-responsive' src='http://placehold.it/990x80'></div>"
    
    f2.puts "<a href='#{nextPage}.html' title='#{headerh1}'>Siguiente</a> "
  
  end
end


createHTML('portada', 'futbol');
createHTML('futbol', 'baloncesto');
createHTML('baloncesto', 'ciclismo');
createHTML('ciclismo', 'golf');
createHTML('golf', 'tenis');
createHTML('tenis', 'motor');
createHTML('motor', 'masdeporte');
createHTML('masdeporte', 'portada');
