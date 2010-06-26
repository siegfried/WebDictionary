$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'entry'
require 'json'

describe Entry do

  describe '#new' do
    it 'should initialize with id and translations' do
      entry = Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'})
      entry.id.should == 'dog'
      entry.translations.should == {'en' => 'dog', 'fr' => 'chien'}
    end
  end

  describe '#create_from_request' do
    it 'should create entry with json request' do

      request = mock('json request')
      request.stub!(:form_data?).and_return(false)
      request.stub!(:media_type).and_return('application/json')
      body = mock('body')
      body.stub!(:read).and_return(JSON.generate({'en' => 'dog', 'fr' => 'chien'}))
      request.stub!(:body).and_return(body)
      request.stub!(:params).and_return({'id' => 'dog'})

      entry = Entry.create_from_request(request)
      entry.to_hash.should == {'_id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}}

    end
  end

  describe '#create_from_request' do
    it 'should create entry with form request' do

      request = mock('form request')
      request.stub!(:form_data?).and_return(true)
      request.stub!(:params).and_return({'id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}})

      entry = Entry.create_from_request(request)
      entry.to_hash.should == {'_id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}}

    end

    it 'should raise UnknownMediaTypeError' do

      request = mock('unknown request')
      request.stub!(:form_data?).and_return(false)
      request.stub!(:media_type).and_return('unknown')

      lambda {Entry.create_from_request(request)}.should raise_error(UnknownMediaTypeError)

    end
  end

  describe '#create_from_hash' do
    it 'should create entry with hash from database collection' do
      hash = {'_id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}}
      entry = Entry.create_from_hash(hash)
      entry.id.should == 'dog'
      entry.translations.should == {'en' => 'dog', 'fr' => 'chien'}
    end
  end

  describe '#to_json' do
    it 'should convert to json' do
      entry = Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'})
      entry.to_json.should == JSON.generate({'en' => 'dog', 'fr' => 'chien'})
    end
  end

  describe '#to_s' do
    it 'should receive to_json' do
      entry = Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'})
      entry.should_receive(:to_json)
      entry.to_s
    end
  end

  describe '#==' do
    it 'should equal to the entry object with the same id and translations' do
      Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'}) == Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'})
    end
  end

  describe '#to_hash' do
    it 'should convert to hash' do
      Entry.new('dog', {'en' => 'dog', 'fr' => 'chien'}).to_hash.should == {'_id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}}
    end
  end

end
