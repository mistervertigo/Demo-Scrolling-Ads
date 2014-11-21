#!/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'nokogiri'


def createArticles (page)
  
  html = open("#{page}").read
  article = Nokogiri::HTML(html)
  
  article.search("h5").each do |x|
    marca_article = x.at_css("a")['href']
    marca_article_title = x.at_css("a[href]").text
    dominio = "http://www.marca.com"
    
    myfile = "#{marca_article}".split('/')[-1]
    
    allmyfiles = "/Users/Leo/Sites/Demo-Scrolling-Ads/noticias/#{myfile}"
    
    #puts "#{marca_article_title}"
    #puts "#{allmyfiles}"
     
    File.new("#{allmyfiles}", "w")
    
    html = open("#{dominio}#{marca_article}").read
    article = Nokogiri::HTML(html)
  
    File.open("#{allmyfiles}", "r+") do |f2|
    
      header = article.at_css(".contenido_not h2").text()
      sign = article.at_css(".contenido_not p.firma").text()
      text = article.at_css(".contenido_not p").text()
      photo = article.at_css(".contenido_not img")['src']
    
      myid = myfile.split(".")[0]
      
      puts myid
    
      f2.puts "<section id='noticia_#{myid}'>"
      f2.puts "<h1>#{header}</h1>"
      f2.puts "<small>#{sign}</small>"
      f2.puts "<img src='#{photo}' />"
      f2.puts "<p>#{text}</p>"
      f2.puts "</section>"
      f2.puts "<a href='noticias/#{myfile}' title='#{myid}'>Siguiente</a>"
    end
    
  end

end

print "Listado de noticias: "
url = gets.chomp

createArticles ("#{url}")