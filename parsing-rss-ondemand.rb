#!/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'nokogiri'


print "URL RSS: "

rss = gets.chomp

print "Nombre del HTML: "

name_file = gets.chomp

print "Relacionado con: "

next_name_file = gets.chomp






def createHTML (url, myRss, nextPage, section)
  
  
    File.new("#{myRss}.html", 'w')
  
  #url = "http://estaticos.elmundo.es/#{section}rss/#{myRss}.xml"
  
    puts "#{url}"
    
    
  rss = Nokogiri::XML(open("#{url}"))
  # check for parsing errors...
  puts "Errors exist" if (rss.errors.any?)

  myfile = "/Users/Leo/Sites/Demo-Scrolling-Ads/#{myRss}.html"
        #myfile = "/home/ubuntu/www/Demo-Scrolling-Ads/#{myRss}.html"


  File.open("#{myfile}", "r+") do |f2|
    header = rss.at_css('channel title').text
    headerh1 = header.split("//")[0]
    headerSmall = header.split("//")[1]
    f2.puts "<section id='#{myRss}'>"
    if myRss == 'portada'
      f2.puts "<div class='page-header'><h1>#{headerh1}</h1></div>"
    else
       f2.puts "<div class='page-header'><h2>#{headerh1}</h2></div>"
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
        f2.puts "<p class='lead'>#{description1}...</p>"
      else
        f2.puts "<h4><a href='#{link}'>#{title}</a><br><small class='text-muted'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> #{author} |  #{pubdate}</small></h4>"
        f2.puts "<p class='lead low'>#{description}</p>"
      end
      
    
      f2.puts "</li>"

    end
    f2.puts "</ul>"
    
    f2.puts "<div class='ads'><img class='img-responsive' src='http://placehold.it/990x80'></div>"
      f2.puts "</section>"
    f2.puts "<a href='#{nextPage}.html' title='#{myRss}'>Siguiente</a> "
  
  
  end
end

puts "#{rss} \n #{name_file} \n #{next_name_file}"
createHTML("#{rss}", "#{name_file}", "#{next_name_file}", "");


#createHTML('portada', 'futbol', 'elmundodeporte/');
