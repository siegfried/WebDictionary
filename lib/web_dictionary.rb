require 'sinatra'
require 'entry'

class WebDictionary < Sinatra::Application

  helpers do
    def dictionary
      options.dictionary
    end
  end

  # GET /entries/{entry-id}.json
  get '/entries/:id.json' do
    dictionary[params[:id]]
  end

  # GET /entries.json
  get '/entries.json' do
    dictionary.all
  end

  # DELETE /entries/{entry-id}
  delete '/entries/:id' do
    dictionary.delete(params[:id])
  end

  # PUT /entries/{entry-id}
  put '/entries/:id' do
    request['id'] = params[:id]
    dictionary.save(Entry.create_from_request(request))
  end

end
