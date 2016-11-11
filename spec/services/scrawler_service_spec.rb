require 'rails_helper'

RSpec.describe ScrawlerService do
  before do
    @service = ScrawlerService.new('http://www.tudogostoso.com.br/')
  end

  context '.initialize' do

    it 'should store the website' do
      expect(@service.website).to eq('http://www.tudogostoso.com.br/')
    end

    it 'should store the current page' do
      expect(@service.current_page).to eq(1)
    end
  end

  context '.next_page' do

    before do
      @service.next_page
    end

    it 'should change the current page' do
      expect(@service.current_page).to eq(2)
    end
  end

  context '.valid_html' do

    before do
      @service.find_html
    end

    context 'with a valid HTML' do
      it { expect(@service.valid_html?('<abacate></abacate>')).to be_truthy }
    end

    context 'with a invalid HTML' do
      it { expect(@service.valid_html?('<p>')).to be_falsey }
    end

  end

end
