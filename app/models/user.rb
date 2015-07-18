# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :text             default(""), not null
#  encrypted_password     :text             default(""), not null
#  reset_password_token   :text
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :text
#  last_sign_in_ip        :text
#  created_at             :datetime
#  updated_at             :datetime
#  username               :text
#  notifications          :text
#

class User < ActiveRecord::Base
  acts_as_voter
  
  acts_as_marker 

  serialize :notifications, Array

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  
  has_many :explanation_authors
  has_many :explanations, through: :explanation_authors

  has_many :solutions, foreign_key: :author_id

  attr_accessor :login
  
  has_many :comments

  #attributes: name, background [string. for now]
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def notify!(type, *args)
    notification = "error" # should never show this

    case type 
    when :solution_comment 
      user = args[0]
      solution = args[1]

      notification = "(#{Time.now.strftime('%m/%d/%Y %H:%M')}) <a href=\"/users/#{user.id}\">#{user.username}</a> left a comment on your solution to a <a href=\"/problems/#{solution.problem.id}\">problem</a>."
      if solution.problem.description.length > 0
        notification += " (#{solution.problem.description})"
      end
    when :solution_upvote
      user = args[0]
      solution = args[1]

      notification = "(#{Time.now.strftime('%m/%d/%Y %H:%M')}) <a href=\"/users/#{user.id}\">#{user.username}</a> upvoted your solution to a <a href=\"/problems/#{solution.problem.id}\">problem</a>."
      if solution.problem.description.length > 0
        notification += " (#{solution.problem.description})"
      end
    end

    self.notifications.unshift(notification)
    save!
  end
end
