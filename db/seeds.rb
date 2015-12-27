User.destroy_all

u = User.create(name: "tomyuk", email: "tom.yuk.g@gmail.com", password: "hogehoge")
(1..20).each do |i|
  Micropost.create(user: u, content: "テストメッセージ\nその#{i}")
end

u = User.create(name: "test", email: "test@example.com", password: "hogehoge")
(1..20).each do |i|
  Micropost.create(user: u, content: "テストメッセージ\nTEST@EXAMPLE.COM\nその#{i}")
end

(1..40).each do |i|
  u = User.find_or_create_by(name: "test#{i}", email: "test#{i}@dot.com")
  u.password = 'hogehoge'
  u.save!
end

u1 = User.find(3)
(1..20).each do |i|
  Micropost.create(user: u1, content: "テストメッセージ\n#{u1.email}\nその#{i}")
end

(4..40).each do |i|
  u = User.find(i)
  u1.follow(u)
  u.follow(u1)
end

u2 = User.second
(3..30).each do |i|
  u = User.find(i)
  u2.follow(u)
  u.follow(u2)
end

(1..20).each do |i|
  Micropost.create(user: u2, content: "テストメッセージ\nサンプルです。\nその#{i}")
end