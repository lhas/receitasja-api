require 'wombat'
require 'nokogiri'

class TudoGostosoService
  attr_reader :website, :current_page

  def initialize
    @website      = 'http://www.tudogostoso.com.br'
    @current_page = 39
  end

  def next_page
    @current_page += 1
  end

  def valid_html?(string)
    Nokogiri::XML(string).errors.empty?
  end

  def final_path
    path = @website + '/receita/' + @current_page.to_s + '-a.html'

    path
  end

  def crawl(path = nil)
    path = path.nil? ? final_path : path

    Wombat.configure do |config|
      config.set_user_agent "Wombat"
    end

    content = Wombat.crawl do
      base_url path

      breadcrumb 'css=span[typeof="v:Breadcrumb"]', :iterator do
        link 'css=a'
      end

      title css: 'h1[itemprop="name"]'
      stars css: 'span[itemprop="ratingValue"]'

      time_to_cook xpath: "//time[@itemprop = \"totalTime\"]/@datetime"
      recipe_yield xpath: "//data[@itemprop = \"recipeYield\"]/@value"

      favorites css: "div.data.clearfix.gray-box .like.block .label"
      
      ingredients "css=.ingredients-box li", :list

      directions "css=.directions-box .instructions li", :list
    end

    content
  end

end