require 'rails_helper'

describe MovieReviews do
  before(:each) do
    attrs = {
      results: [
        {
          "author": "Goddard",
          "content": "Pretty awesome movie."
        }, 
        {
          "author": "Brett Pascoe",
          "content": "In my top 5 of all time favourite movies."
        }
      ]
    }
    @movie_reviews = MovieReviews.new(attrs)
  end

  it 'exists' do
    expect(@movie_reviews).to be_a MovieReviews
    expect(@movie_reviews.results[0][:author]).to eq('Goddard')
    expect(@movie_reviews.results[0][:content]).to eq('Pretty awesome movie.')
    expect(@movie_reviews.results[1][:author]).to eq('Brett Pascoe')
    expect(@movie_reviews.results[1][:content]).to eq('In my top 5 of all time favourite movies.')
  end

  describe '#reviews' do
    it 'returns the author and content of each review in a specific format' do
      expect(@movie_reviews.reviews).to eq(["Goddard: Pretty awesome movie.", "Brett Pascoe: In my top 5 of all time favourite movies."])
    end
  end
end