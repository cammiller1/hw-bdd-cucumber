# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    #---- added ----#
    #add each movie into the movie object
    Movie.create!(movie)
    #---------------#
  end
#   fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
#   fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  #---- added ----#
  #log("***** rating_list #{rating_list}")
  #log("***** uncheck #{uncheck}")
    
  tokens = rating_list.split(', ')
    
  tokens.each do |field|
      #log("******ratings_#{field}******")
      #log("******hi******")
      if uncheck == ""
          check("ratings_#{field}")
      elsif uncheck == "un"
          uncheck("ratings_#{field}")
      end
  end
  #---------------#
  
#   fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
#   fail "Unimplemented"
end

# added
When /I press (.*)/ do |button|
  id = "ratings_" + button
  #log("*****************#{id}")
  click_button(id)
end

# added
Then /I should see the following : (.*)/ do |movie_titles_string|
    log("*****************hi")
    movie_titles_array = movie_titles_string.split(', ')
    log("***** movie_titles_array #{movie_titles_array}")
    movie_titles_array.each do |title|
        log("*****#{regexp}")
        regexp = Regexp.new(title)

        if page.respond_to? :should
            page.should have_xpath('//*', :text => regexp)
        else
            assert page.has_xpath?('//*', :text => regexp)
        end
    end
end

# added
Then /I should see: (.*)/ do |movie_title|
    
    regexp = Regexp.new(movie_title)
    
    if page.respond_to? :should
        page.should have_xpath('//*', :text => regexp)
    else
        assert page.has_xpath?('//*', :text => regexp)
    end
end

# added
Then /I shouldn't see: (.*)/ do |movie_title|
    regexp = Regexp.new(movie_title)
    
    if page.respond_to? :should
        page.should !have_xpath('//*', :text => regexp)
    else
        assert !page.has_xpath?('//*', :text => regexp)
    end
end