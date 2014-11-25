#!/bin/env ruby
# encoding: utf-8

#http://www.elmundo.es/comunidad-valenciana/2014/11/23/54722342ca4741967c8b4580.html

require 'open-uri'
require 'nokogiri'

  


def createArticles (ficheros, urls, nxt, id)
  File.new("#{ficheros}", "w")
  
  puts "Generaring... #{ficheros}"
  
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
    
    
    f2.puts %{
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <meta name="description" content="">
      <meta name="author" content="">

      <title>Demo Scrolling Article Related News</title>

              <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
              <!-- Optional theme -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
       <link href="http://getbootstrap.com/examples/dashboard/dashboard.css" rel="stylesheet">
       <link rel="stylesheet" href="commons/css/style.css?09090" type="text/css">
        </head>
      <style>
      #el_levante_hace_sangrar_al_sevilla_2 h1{font-size:44px;}
      section.article{background:#fff;}
      </style>
        <body>

                <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                  <div class="container-fluid">
                    <div class="navbar-header">
                      <a class="navbar-brand" href="/Demo-Scrolling-Ads/">
                        ELM - Deportes
                      </a>
                    </div>
                  </div>
                </nav>
                                  <div class="container-fluid">
                                    <div class="row">
                      <div class="col-sm-3 col-md-2 sidebar">
                                 
                        <ul class="nav nav-sidebar inside" id="menu-center">
                                                              <li role="presentation" class="el_levante_hace_sangrar_al_sevilla_2 origen active"><a href="#el_levante_hace_sangrar_al_sevilla_2">El Levante hace sangrar al Sevilla</a></li>
																		  
      																		   <li role="presentation" class="related">Artículos relacionados</li>
                                              <li role="presentation" class="el_levante_ya_gana_en_casa_2"><a href="#el_levante_ya_gana_en_casa_2">El Levante ya gana en casa</a></li>
                                              <li role="presentation" class="alcaraz_se_estrena_con_derrota_2"><a href="#alcaraz_se_estrena_con_derrota_2">Alcaraz se estrena con derrota</a></li>
                                              <li role="presentation" class="goles_para_tributar_a_peter_2"><a href="#goles_para_tributar_a_peter_2">Goles para tributar a Peter</a></li>
                                              <li role="presentation" class="mestalla_pierde_su_magia_2"><a href="#mestalla_pierde_su_magia_2">Mestalla pierde su magia</a></li>
                                       </ul>
                                 
                      </div>
                                      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                                                
                                                              <div class="scroll" id="resultados" data-ui="jscroll-default">
    }
    
 
    f2.puts "<span id='mycontent'>"
    f2.puts "<section id='#{id}' class='article'>"
    f2.puts "<h1>#{header}</h1>"
    f2.puts "#{resume}"
    f2.puts "<div class='foto'><img class='img-responsive' src='#{photo}' alt='#{altphoto}' />"
    f2.puts "#{sign}"
    f2.puts "#{fecha}</div>"
    f2.puts "#{text}"
    f2.puts "<div class='ads'><img class='img-responsive' src='http://placehold.it/900x80'></div>"
    f2.puts "</section>"

    f2.puts "<hr>"
    f2.puts "<a href='#{nxt}_2.html' title='#{id}_2'>Siguiente</a>"
    f2.puts "</span>"
    
     f2.puts %{
      
                                                </div>
                                </div>
                              </div>
                            </div>

               

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
         <script src="http://getbootstrap.com/assets/js/docs.min.js"></script>
         <script src="commons/js/jscroll.js"></script>mestalla_pierde_su_magia
          <script src="commons/js/waypoints.min.js"></script>
			<script src="commons/js/script.js"></script>


 

  </body>
</html>
    
    }
    
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
    
    allmyfiles = "/Users/Leo/Sites/Demo-Scrolling-Ads/#{myfile}_2.html"   
    
    #sample.push myfile
    
    nextpage = x.next_element.at_css("a")['href'].split('=')[-1]
    
  
    createArticles(allmyfiles, site_article, nextpage, myfile)
    

    
    
  end
end

print "Listado de noticias: "
url = gets.chomp

readArticles ("#{url}")