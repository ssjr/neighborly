require 'ffaker'

# Disable sidekiq
require 'sidekiq/testing'
Sidekiq::Testing.fake!

puts 'Creating Configuration entries...'

  {
    company_name: 'Neighbor.ly',
    host: 'localhost',
    base_url: 'http://localhost',
    blog_url: 'http://blog.neighbor.ly',
    base_domain: 'localhost',
    email_contact: 'howdy@neighbor.ly',
    email_payments: 'books@neighbor.ly',
    email_system: 'no-reply@neighbor.ly',
    email_no_reply: 'no-reply@neighbor.ly',
    facebook_url: 'http://www.facebook.com/NEIGHBORdotLY',
    facebook_app_id: 255971384512404,
    twitter_username: 'Neighborly',
    catarse_fee: 0.05,
    support_forum: 'http://neighborly.uservoice.com/',
    project_finish_time: '02:59:59',
    secret_token: SecureRandom.hex(64),
    secret_key_base: SecureRandom.hex(64),
    currency_charge: 'USD',
    google_analytics_id: 'SOMETHING',
    email_projects: 'ideas@neighbor.ly',
    timezone: 'US/Central',
    devise_secret_key: SecureRandom.hex(64),
    #secure_review_host: nil,
    #uservoice_key: nil,
    #mailchimp_api_key: nil,
    #mailchimp_list_id: nil,
    #mailchimp_url: nil,
    #mandrill_user_name: nil,
    #mandrill: nil,
    #aws_bucket: nil,
    #aws_access_key: nil,
    #aws_secret_key: nil,
    #paypal_username: nil,
    #paypal_password: nil,
    #paypal_signature: nil,
    #stripe_api_key: nil,
    #stripe_public_key: nil,
    #authorizenet_login_id: nil,
    #authorizenet_transaction_key: nil
  }.each do |name, value|
     Configuration[name] = value
  end

puts '---------------------------------------------'
puts 'Done!'


puts 'Creating OauthProvider entries...'

  categories = %w{facebook twitter google_oauth2 linkedin}
  categories.each do |name|
    OauthProvider.create! name: name, path: name, secret: 'SOMETHING', key: 'SOMETHING'
  end

puts '---------------------------------------------'
puts 'Done!'


puts 'Creating Category entries...'

  categories = %w{Transit Bicycling Technology Entertainment Sports Recreation Schools Streetscapes Environment Restoration Event Mobility}
  categories.each do |c|
    Category.create! name_pt: c, name_en: c
  end

puts '---------------------------------------------'
puts 'Done!'

puts 'Creating Admin user...'
  u = User.new name: 'Admin',
                   email: 'admin@admin.com',
                   password: 'password'
  u.admin = true
  u.skip_confirmation!
  u.confirm!
  u.save

puts '---------------------------------------------'
puts 'Done!'

puts 'Creating Test user...'

  User.new admin: false,
               name: 'Test',
               email: 'test@test.com',
               password: 'password'
  u.admin = true
  u.skip_confirmation!
  u.confirm!
  u.save

puts '---------------------------------------------'
puts 'Done!'

puts 'Creating Organization user...'

  u = User.new name: 'Organization',
                   email: 'org@org.com',
                   password: 'password',
                   profile_type: 'organization'
  u.admin = true
  u.confirm!
  u.save

puts '---------------------------------------------'
puts 'Done!'

puts 'Creating Channel user...'

  u = User.new name: 'Channel',
                   email: 'channel@channel.com',
                   password: 'password',
                   profile_type: 'channel'
  u.admin = true
  u.skip_confirmation!
  u.confirm!
  u.save

puts '---------------------------------------------'
puts 'Done!'

puts 'Creating system users...'

  # User to receive company contact notifications
  u = User.new email: Configuration[:email_contact], password: SecureRandom.hex(4)
  u.skip_confirmation!
  u.confirm!
  u.save

  # User to receive new projects on draft notifications
  u = User.new email: Configuration[:email_projects], password: SecureRandom.hex(4)
  u.skip_confirmation!
  u.confirm!
  u.save

puts '---------------------------------------------'
puts 'Done!'

puts 'Creating channel...'

  Channel.create! user: User.where(email: 'channel@channel.com').first, name: 'Channel', permalink: 'channel', description: Faker::Lorem.sentence

puts '---------------------------------------------'
puts 'Done!'