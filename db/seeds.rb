# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seed start"

ApplicationRecord.connection.execute("SET FOREIGN_KEY_CHECKS=0")
ApplicationRecord.connection.execute("TRUNCATE users")
ApplicationRecord.connection.execute("TRUNCATE topics")
ApplicationRecord.connection.execute("SET FOREIGN_KEY_CHECKS=1")

Role.create!([
  {name: 'admin'},
  {name: 'member'}
])

User.create!([
  {email: 'test@test.com', name: 'test', password: '12345678', password_confirmation: '12345678'}
])

user = User.last

user.topics.create!([
  {title: 'Test 1', node_id: 2, body: 'test', body_html: '<p>test 1</p>'},
  {title: 'Test 2', node_id: 2, body: 'test', body_html: '<p>test 2</p>'},
  {title: 'Test 3', node_id: 2, body: 'test', body_html: '<p>test 3</p>'},
  {title: 'Test 4', node_id: 2, body: 'test', body_html: '<p>test 4</p>'},
  {title: 'Test 5', node_id: 2, body: 'test', body_html: '<p>test 5</p>'}
])

Node.create!([
  {name: 'private', slug: 'private', title: '私有', publish: false},
  {name: 'ruby', slug: 'ruby', title: 'Ruby', publish: true},
  {name: 'rails', slug: 'rails', title: 'Rails', publish: true},
  {name: 'linux', slug: 'linux', title: 'Linux', publish: true},
  {name: 'elasticsearch', slug: 'elasticsearch', title: 'Elasticsearch', publish: true}
])

puts "seed end"