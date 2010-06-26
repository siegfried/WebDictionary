require 'Entry'

class Dictionary
  def initialize(collection)
    @collection = collection
  end
  def [](id)
    Entry.create_from_hash(@collection.find_one({'_id' => id}))
  end
  def delete(id)
    @collection.remove({'_id' => id})
  end
  def save(entry)
    @collection.save(entry.to_hash)
  end
end
