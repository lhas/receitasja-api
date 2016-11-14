require 'rails_helper'

RSpec.describe TudoGostosoService do
  before do
    @service = TudoGostosoService.new('http://www.tudogostoso.com.br')
  end

  context '.initialize' do

    it 'should store the website' do
      expect(@service.website).to eq('http://www.tudogostoso.com.br')
    end

    it 'should store the current page' do
      expect(@service.current_page).to eq(39)
    end
  end

  context '.next_page' do

    before do
      @service.next_page
    end

    it 'should change the current page' do
      expect(@service.current_page).to eq(40)
    end
  end

  context '.valid_html' do

    context 'with a valid HTML' do
      it { expect(@service.valid_html?('<abacate></abacate>')).to be_truthy }
    end

    context 'with a invalid HTML' do
      it { expect(@service.valid_html?('<p>')).to be_falsey }
    end

  end

  context '.fake_path' do
    context 'with the current page' do
      it { expect(@service.fake_path).to eq('/receita/39-a.html') }
    end
  end

  context '.crawl' do
    context 'the url from current page' do
      it { expect(@service.crawl).to be_a(Hash) }
    end
  end

end
