require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Juan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for Juan')
  post = Post.create(author: user, title: 'Title1', text: 'Text1')

  subject { Like.new(author: user, post: post) }

  before { subject.save }

  it 'should increment post likes counter' do
    subject { Like.new(author: user, post: post) }
    counter = post.likes_counter
    subject.save
    expect(post.likes_counter).to eq(counter + 1)
  end
end
