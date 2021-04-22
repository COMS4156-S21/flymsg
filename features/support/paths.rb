# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
require 'base64'

module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def path_to(page_name)
      case page_name
  
      when /^the home page$/ then '/'
  
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
      
      when /the encrypt page/ then encrypt_index_path()
  
      when /the decrypt page/ then decrypt_index_path()

      when /the login page/ then login_path()

      when /the new users page/ then create_path()

      when /the view page for "(.*)"/ then view_path(Base64.strict_encode64($1))
  
      # when /the Similar Movies page for "(.*)"/ then movies_similar_path(:director => Movie.find_by(title: $1).director)
  
      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
      end
    end
  end
  
  World(NavigationHelpers)
  