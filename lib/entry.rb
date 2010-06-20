require 'json'
require 'errors'

class Entry
  def initialize(request)
    if request.form_data?
      @id = request.params['id']
      @translations = request.params['translations']
    else
      if request.media_type == 'application/json'
        @id = request.params['id']
        @translations = JSON.parse(request.body.read)
      end
    end
  end
  def to_hash
    {'_id' => @id, 'translations' => @translations}
  end
end
