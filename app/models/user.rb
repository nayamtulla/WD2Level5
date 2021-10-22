#class User < ApplicationRecord
#end

class User < ActiveRecord::Base
  def to_pleasant_string
    "#{id_no}. #{username} #{email_id}"
  end
end
