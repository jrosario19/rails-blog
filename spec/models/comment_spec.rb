require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Juan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for Juan')
  post = Post.create(author: user, title: 'Title1', text: 'Text1')

  subject { Comment.new(author: user, post: post, text: 'Comment1') }

  before { subject.save }

  it 'should increment post comments counter' do
    counter = post.comments_counter
    subject.save
    expect(post.comments_counter).to eq(counter + 1)
  end
end
