#!/bin/env ruby
# encoding: utf-8

require 'rubygems'
require 'json'

require 'rss'
require 'open-uri'


url = 'http://estaticos.elmundo.es/elmundodeporte/rss/portada.xml'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  myfile = "/Users/Leo/Sites/Demo-Scrolling-Ads/content.html"
 
  File.open("#{myfile}", "w") do |f2|
    f2.puts "<h3>Portada Deportes</h3>"
    feed.items.each do |item|
      f2.puts "<h4>#{item.title}</h4> "
      f2.puts "<p>#{\item.media:description}</p> "
    end
    f2.puts "<a href='futbol.html'>next page</a> "
  end
end

url = 'http://estaticos.elmundo.es/elmundodeporte/rss/futbol.xml'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  myfile = "/Users/Leo/Sites/Demo-Scrolling-Ads/futbol.html"
 
  File.open("#{myfile}", "w") do |f2|
    f2.puts "<h3>Fútbol</h3>"
  feed.items.each do |item|
    f2.puts "<h4>#{item.title}</h4> "
     f2.puts "<p>#{item.description}</p> "
       
    end
    f2.puts "<a href='baloncesto.html'>next page</a> "
  end
end

url = 'http://estaticos.elmundo.es/elmundodeporte/rss/baloncesto.xml'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  myfile = "/Users/Leo/Sites/Demo-Scrolling-Ads/baloncesto.html"
 
  File.open("#{myfile}", "w") do |f2|
    f2.puts "<h3>Baloncesto</h3>"
  feed.items.each do |item|
    f2.puts "<p>#{item.title}</a> "
       
    end
    f2.puts "<a href='deportes.html'>next page</a> "
  end
end

url = 'http://estaticos.elmundo.es/elmundodeporte/rss/masdeporte.xml'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  myfile = "/Users/Leo/Sites/Demo-Scrolling-Ads/deportes.html"
 
  File.open("#{myfile}", "w") do |f2|
    f2.puts "<h3>Más deporte</h3>"
  feed.items.each do |item|
    f2.puts "<p>#{item.title}</a> "
    
    end
  end
end