$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'dictionary'

describe Dictionary do

  before :each do
    @collection = mock('database collection')
    @dictionary = Dictionary.new(@collection)
  end

  describe '#[]' do
    it 'should invoke find one method of database collection' do
      row = mock('row')
      @collection.should_receive(:find_one).with({'_id' => 'dog'}).and_return(row)
      Entry.should_receive(:create_from_hash).with(row)
      @dictionary['dog']
    end
  end

  describe '#delete' do
    it 'should invoke remove method of database collection' do
      @collection.should_receive(:remove).with({'_id' => 'dog'})
      @dictionary.delete('dog')
    end
  end

  describe '#save' do
    it 'should invoke save method of database collection' do
      entry = mock('entry')
      hash = mock('hash')
      entry.should_receive(:to_hash).with(no_args).and_return(hash)
      @collection.should_receive(:save).with(hash)
      @dictionary.save(entry)
    end
  end

end
