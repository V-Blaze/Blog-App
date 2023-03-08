# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create some users
User.create!([
  { name: "Tom", photo: "https://randomuser.me/api/portraits/men/60.jpg", 
    bio: "Teacher from Mexico.", posts_counter: 0 },
  { name: "Lilly", photo: "https://randomuser.me/api/portraits/women/56.jpg", 
    bio: "Teacher from Poland.", posts_counter: 0 }
 ])
# Create some posts for Tom and Lilly
Post.create!([
  { title: "My first post", text: "This is my first post and I'll try to write something nice", author_id: 1 },
  { title: "My name is Lilly Potter", text: "I'm the woman who used the ancient magic of love to protect my son by sacrificing myself in front of Voldemort", 
    author_id: 2 },
  { title: "Yaaaaay! Vacation is comming!", text: "I am going to go to mountain this summer. I am sort of bored of seaside", 
    author_id: 1 },
  { title: "Writing to my friend, Severus Snape", text: "I didn't hear about Severus in quite some time now and I really wander what he's up to", 
    author_id: 2 }
])
# Create some comments for Tom's and Lilly's posts
Comment.create!([
  { text: "I am so glad for you that you started posting again!", author_id: 2, post_id: 1 },
  { text: "I thought your name was Lilly Evans, wasn't it?", author_id: 1, post_id: 2 },
  { text: "Yeah, it was, but that was before I married James Potter", author_id: 2, post_id: 2 },
  { text: "I was thinking to start an online blog (out of all things)", author_id: 1, post_id: 1 },
  { text: "I'm afraid this year I won't have time for vacations, either way", author_id: 2, post_id: 3 },
  { text: "You should consider taking some time, as now Harry is an Auror and Voldemort is no more", author_id: 1, post_id: 3 },
  { text: "Severus Snape is no more. He killed Dumbledore and then got killed by Voldemort", author_id: 1, post_id: 4 },
  { text: "WHAAAAAAT?", author_id: 2, post_id: 4 }
])
# Create some likes
Like.create!([
  { author_id: 2, post_id: 1 },
  { author_id: 1, post_id: 4 }
])
