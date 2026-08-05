# Create your admin account (the only user who can publish).
# Change the email/password before deploying.
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.password = "password"
admin.password_confirmation = "password"
admin.role = :admin
admin.save!

samples = [
  {
    title: "Welcome to the blog",
    body: "This is your first post. Sign in as admin to edit or add more.",
    topic: "Meta",
    view_count: 12
  },
  {
    title: "Shipping a Rails blog without overbuilding",
    body: "Keep public reads simple, put writes behind admin, and measure what topics actually get read.",
    topic: "Rails",
    view_count: 48
  },
  {
    title: "What I look for when reviewing my own PRs",
    body: "Clarity beats cleverness. Name things for the next reader. Delete the code you cannot defend.",
    topic: "Career",
    view_count: 31
  }
]

samples.each do |attrs|
  post = Post.find_or_initialize_by(title: attrs[:title])
  post.assign_attributes(attrs)
  post.published_at ||= Time.current
  post.save!
end

puts "Seeded admin (admin@example.com / password) and sample posts."
