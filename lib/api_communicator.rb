require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
    # char_found = nil
    # while char_found == nil
    #     characters_array = character_hash["results"]
    #     char_found = characters_array.find do |character|
    #       character["name"] == character
    #     end
    #     if char_found == nil
    #       character_hash["next"]
    #     end
    #

    char_found = nil
    next_page = ""
    count = 1
    while char_found == nil
      char_found = search_page_for_character(character_hash, character)
      if char_found
          puts "found character"
          break
      end
      puts "not found in page #{count}...checking next page #{count + 1}"
      count += 1
      next_page = get_next_page(character_hash)
      if(!next_page) then break end
      character_hash = fetch_readable_api_data(next_page)
    end

    if char_found == nil
      puts "character not found, please try again"
    end


  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

    #parse_character_movies

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film


  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

  def fetch_readable_api_data(next_page)
    all_characters = RestClient.get(next_page)
    JSON.parse(all_characters)
  end

 def search_page_for_character(character_hash, character_name)
   characters_array = character_hash["results"]
   characters_array.find do |character_hash|
     character_hash["name"] == character_name
   end
 end

def get_next_page(character_hash)
    character_hash["next"]
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

get_character_movies_from_api("Lu Skywalker")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
