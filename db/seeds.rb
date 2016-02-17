# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "這個種子檔會自動建立一個帳號, 並且創建 20 個 groups, 每個 group 各 30 個 posts"

User.create([{
    email: 'test@test.com',
    name: 'Test',
    password: '12345678',
    password_confirmation: '12345678'
}])

@account = User.where(email: 'test@test.com').take

for i in 1..20 do

  @group = Group.create([{
    title: "Group no.#{i}",
    description: "這是用種子建立的第 #{i} 個討論版"
  }])
  @account.join!(@group)

  for j in 1..30 do

    Post.create([{
      content: "這是用種子建立的第 #{j} 個留言",
      group_id: "#{i}",
      user_id: 1
    }])

  end

end
