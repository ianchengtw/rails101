# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Create 20 groups with 30 posts for each"
@robot = 'Robot - Winky'

User.create({
  name: @robot,
  email: 'ian@ian.idv',
  password: 'asdfasdf',
  password_confirmation: 'asdfasdf'
})

@account = User.where(email: 'ian@ian.idv').take

for i in 1..20 do

  @group = Group.create({
    title: "Group no.#{i}",
    description: "Group no.#{i} generated by #{@robot}",
    user_id: @account.id
  })
  @account.join!(@group)

  for j in 1..30 do
    Post.create({
      content: "Post no.#{i} generated by #{@robot}",
      group_id: "#{i}",
      user_id: @account.id
    })
  end

end
