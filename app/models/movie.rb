class Movie < ActiveRecord::Base
  def self.allRatings
    return ['G', 'PG', 'PG-13', 'R']
  end
end
