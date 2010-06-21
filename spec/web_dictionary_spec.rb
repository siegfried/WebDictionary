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

  # GET /entries/{entry-id}.json
  # Media type is application/json
  it 'should invoke [] method' do
    @dictionary.should_receive(:[]).with('dog')
    get '/entries/dog.json'
  end

  # GET /entries.json
  # Media type is application/json
  it 'should invoke all method' do
    @dictionary.should_receive(:all).with(no_args)
    get '/entries.json'
  end

  # DELETE /entries/{entry-id}
  # No matter what media type it is
  it 'should invoke delete method' do
    @dictionary.should_receive(:delete).with('dog')
    delete '/entries/dog'
  end

  # PUT /entries/{entry-id}
  it 'should invoke save method' do
    @dictionary.should_receive(:save).with(Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'}))
    header 'Content-Type', 'application/json'
    put '/entries/dog', JSON.generate({'en' => 'dog', 'fr' => 'chien'})
  end

end
