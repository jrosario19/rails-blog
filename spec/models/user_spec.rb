require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Juan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for Juan') }

  before { subject.save }

  it 'title should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be integer' do
    subject.posts_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it ':recent_posts should return 3 recent posts' do
    3.times { Post.create(author: subject, title: 'Title1', text: 'Post text1') }
    expect(subject.recent_posts.size).to eq(3)
  end
end
