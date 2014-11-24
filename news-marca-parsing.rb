#!/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'nokogiri'

require 'rubygems'
require 'json'
require 'net/http'


def createArticles (ficheros, urls, nxt, id)
  File.new("#{ficheros}", "w")
  
  html = open("#{urls}").read
  article = Nokogiri::HTML(html)

  File.open("#{ficheros}", "w:UTF-8") do |f2|
  
    header = article.at_css(".desarrollo header h1").text()
    resume = article.at_css(".desarrollo header .subtitulos")
    photo = article.at_css("#fotoPrincipal")['src']
    altphoto = article.at_css("div.foto img")['alt']
    sign = article.at_css(".desarrollo div.firma span")
    fecha = article.at_css(".desarrollo time")
    
    text = article.at_css(".desarrollo div#tamano")
    
    
    
 
    puts header
    f2.puts "<section id='#{id}'>"
    f2.puts "<h1>#{header}</h1>"
    f2.puts "#{resume}"
    f2.puts "<div class='foto'><img src='#{photo}' alt='#{altphoto}' /></div>"
    f2.puts "#{sign}"
    f2.puts "#{fecha}"
    f2.puts "<div class='ads'><img class='img-responsive' src='http://placehold.it/300x250'></div>"
    f2.puts "#{text}"
    f2.puts "</section>"
    f2.puts "<a href='noticias/#{nxt}.html' title='#{nxt}'>Siguiente</a>"
    
  end
end

def readArticles (page)
  
  html = open("#{page}").read
  article = Nokogiri::HTML(html)
   #sample = Array.new 
  article.search("section#relatedNews ul li").each do |x|
    site_article = x.at_css("a")['href']
    site_article_title = x.at_css("a[href]").text
    dominio = "http://www.elmundo.es"
    
    myfile = "#{site_article}".split('/')[-1].split('=')[-1]
    
    allmyfiles = "/Users/Leo/Sites/Demo-Scrolling-Ads/noticias/#{myfile}.html"   
    
    #sample.push myfile
    
    nextpage = x.next_element.at_css("a")['href'].split('=')[-1]
    
  
    createArticles(allmyfiles, site_article, nextpage, myfile)
    

    
    
  end
end

print "Listado de noticias: "
url = gets.chomp

readArticles ("#{url}")