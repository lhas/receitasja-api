require 'wombat'
require 'nokogiri'

class TudoGostosoService
  attr_reader :website, :current_page

  def initialize(website)
    @website      = website
    @current_page = 39
  end

  def next_page
    @current_page += 1
  end

  def valid_html?(string)
    Nokogiri::XML(string).errors.empty?
  end

  def fake_path
    '/receita/' + @current_page.to_s + '-a.html'
  end

  def crawl
    current_url = @website + fake_path
    
    Wombat.crawl do
      base_url current_url
      path ''

      headline xpath: "//h1"
      subheading css: "p.alt-lead"

      what_is({ css: ".one-fourth h4" }, :list)

      links do
        explore xpath: '/html/body/header/div/div/nav[1]/a[4]' do |e|
          e.gsub(/Explore/, "Love")
        end

        features css: '.nav-item-opensource'
        business css: '.nav-item-business'
      end
    end
  end

end