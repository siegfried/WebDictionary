require 'json'
require 'errors'

class Entry

  attr_reader :id, :translations

  def initialize(id, translations)
    @id = id
    @translations = translations
  end

  def self.create_from_request(request)
    if request.form_data?
      id = request.params['id']
      translations = request.params['translations']
      return Entry.new(id, translations)
    else
      if request.media_type == 'application/json'
        id = request.params['id']
        translations = JSON.parse(request.body.read)
        return Entry.new(id, translations)
      else
        raise UnknownMediaTypeError
      end
    end
  end

  def self.create_from_hash(hash)
    Entry.new(hash['_id'], hash['translations'])
  end

  def to_hash
    {'_id' => @id, 'translations' => @translations}
  end

  def to_json
    JSON.generate(@translations)
  end

  def to_s
    to_json
  end

  def ==(entry)
    self.id == entry.id and self.translations == entry.translations ? true : false
  end

end
