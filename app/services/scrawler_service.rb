require 'wombat'
require 'nokogiri'

class ScrawlerService
  attr_reader :website, :current_page

  def initialize(website)
    @website      = website
    @current_page = 1
  end

  def next_page
    @current_page += 1
  end

  def find_html
  end

  def valid_html?(string)
    Nokogiri::XML(string).errors.empty?
  end
end