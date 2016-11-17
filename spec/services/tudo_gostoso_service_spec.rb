require 'rails_helper'

RSpec.describe TudoGostosoService do
  before do
    @service = TudoGostosoService.new
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

  context '.final_path' do
    context 'with the current page' do
      it { expect(@service.final_path).to eq('http://www.tudogostoso.com.br/receita/39-a.html') }
    end
  end

  describe '.crawl' do

    before do
      @crawl = @service.crawl
    end

    it 'should a valid hash' do
      expect(@crawl).to be_a(Hash)
    end

    it 'should return the correct recipe breadcrumb' do
      expect(@crawl['breadcrumb'][1]['link']).to eq('Saladas, molhos e acompanhamentos')
    end

    it 'should return the correct recipe title' do
      expect(@crawl['title']).to eq('Molho de tomate')
    end

    it 'should return the correct recipe stars' do
      expect(@crawl['stars']).to eq('4')
    end

    it 'should return the correct recipe time to cook' do
      expect(@crawl['time_to_cook']).to eq('PT50M')
    end

    it 'should return the correct recipe yield' do
      expect(@crawl['recipe_yield']).to eq('4')
    end

    it 'should return the correct recipe favorites' do
      expect(@crawl['favorites']).to eq("17.459\nFavoritos")
    end

    it 'should return the correct recipe ingredient' do
      expect(@crawl['ingredients'][0]).to eq("2 kg de tomate maduro (débora ou italiano) cortado ao meio,sem semente")
    end

    it 'should return the correct recipe directions' do
      expect(@crawl['directions'][0]).to eq("Numa panela, coloque 2 kg de tomate maduro sem sementes e deixe até amolecer")
    end

    context 'multiple recipes' do

      before do
        @current_page_crawl = @service.crawl
        @service.next_page
        @next_page_crawl = @service.crawl
      end

      it 'should still return the first correct recipe' do
        expect(@current_page_crawl['title']).to eq('Molho de tomate')
      end

      it 'should return the second recipe' do
        expect(@next_page_crawl['title']).to eq('Molho de Hortelã ( delicioso com carneiro)')
      end
    end
  end

end
