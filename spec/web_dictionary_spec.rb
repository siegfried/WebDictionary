require 'web_dictionary'
require 'rack/test'

describe WebDictionary do

  include Rack::Test::Methods

  def app
    WebDictionary
  end

  before :all do
    set :environment, :test
  end

  before :each do
    @dictionary = mock('dictionary')
    set :dictionary, @dictionary
  end

  describe ': GET /entries/{entry-id}.json' do
    it 'should invoke [] method' do
      @dictionary.should_receive(:[]).with('dog')
      get '/entries/dog.json'
    end
  end

  describe ': DELETE /entries/{entry-id}' do
    it 'should invoke delete method' do
      @dictionary.should_receive(:delete).with('dog')
      delete '/entries/dog'
    end
  end

  describe ': PUT /entries/{entry-id}' do
    it 'should invoke save method' do
      @dictionary.should_receive(:save).with(Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'}))
      header 'Content-Type', 'application/json'
      put '/entries/dog', JSON.generate({'en' => 'dog', 'fr' => 'chien'})
    end
  end

end
