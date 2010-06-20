$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'entry'
require 'json'

describe Entry do

  it 'should create entry with json request' do

    request = mock('json request')
    request.stub!(:form_data?).and_return(false)
    request.stub!(:media_type).and_return('application/json')
    body = mock('body')
    body.stub!(:read).and_return(JSON.generate({'en' => 'dog', 'fr' => 'chien'}))
    request.stub!(:body).and_return(body)
    request.stub!(:params).and_return({'id' => 'dog'})

    entry = Entry.new(request)
    entry.to_hash.should == {'_id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}}

  end

  it 'should create entry with form request' do

    request = mock('form request')
    request.stub!(:form_data?).and_return(true)
    request.stub!(:params).and_return({'id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}})

    entry = Entry.new(request)
    entry.to_hash.should == {'_id' => 'dog', 'translations' => {'en' => 'dog', 'fr' => 'chien'}}

  end

  it 'should raise UnknownMediaTypeError' do

    request = mock('unknown request')
    request.stub!(:form_data?).and_return(false)
    request.stub!(:media_type).and_return('unknown')

    lambda {Entry.new(request)}.should_raise(UnknowMediaTypeError)

  end

end
