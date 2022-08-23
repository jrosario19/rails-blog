require 'rails_helper'

RSpec.describe 'Post index', type: :system do
  it 'can see the users profile picture' do
    User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    visit '/users'
    expect(page).to have_css('img')
  end

  it 'can see the users name' do
    User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    visit '/users'
    expect(page).to have_content('henry')
  end

  it 'can see the number of posts' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    Post.create(title: 'post1', text: 'text1', author: user)
    Post.create(title: 'post2', text: 'text2', author: user)
    visit '/users'
    expect(page).to have_content('1')
    expect(page).to have_content('2')
  end

  it 'can see the posts title' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    Post.create(title: 'post1', text: 'text1', author: user)
    Post.create(title: 'post2', text: 'text2', author: user)
    visit "/users/#{user.id}/posts"
    expect(page).to have_content('post1')
    expect(page).to have_content('post2')
  end

  it 'can see the first comments on a posts' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    post1 = Post.create(title: 'post1', text: 'text1', author: user)
    post2 = Post.create(title: 'post2', text: 'text2', author: user)
    Comment.create(text: 'comment1', author: user, post: post1)
    Comment.create(text: 'comment2', author: user, post: post2)
    visit "/users/#{user.id}/posts"
    expect(page).to have_content('comment1')
    expect(page).to have_content('comment2')
  end

  it 'can see the number of comments on a post' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    Post.create(title: 'post1', text: 'text1', author: user)
    Post.create(title: 'post2', text: 'text2', author: user)
    Comment.create(text: 'comment1', author: user, post: Post.first)
    Comment.create(text: 'comment2', author: user, post: Post.last)
    visit '/users'
    expect(page).to have_content('1')
    expect(page).to have_content('2')
  end

  it 'can see the how many likes a post has' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    Post.create(title: 'post1', text: 'text1', author: user)
    Post.create(title: 'post2', text: 'text2', author: user)
    Like.create(author: user, post: Post.first)
    Like.create(author: user, post: Post.last)
    visit "/users/#{user.id}/posts"
    expect(page).to have_content('1')
    expect(page).to have_content('2')
  end

  it 'can see a section for pagination' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    Post.create(title: 'post1', text: 'text1', author: user)
    Post.create(title: 'post2', text: 'text2', author: user)
    Post.create(title: 'post3', text: 'text3', author: user)
    Post.create(title: 'post4', text: 'text4', author: user)
    Post.create(title: 'post5', text: 'text5', author: user)
    Post.create(title: 'post6', text: 'text6', author: user)
    Post.create(title: 'post7', text: 'text7', author: user)
    Post.create(title: 'post8', text: 'text8', author: user)
    Post.create(title: 'post9', text: 'text9', author: user)
    Post.create(title: 'post10', text: 'text10', author: user)

    visit "/users/#{user.id}/posts"
    expect(page).to have_content('1')
    click_on 'Next Page'
    expect(page).to have_content('2')
    expect(page).to have_content('Next Page')
    expect(page).to have_content('Previous Page')
  end

  it 'redirects to Post show page when clicking on a post' do
    user = User.create(name: 'henry', photo: '', bio: 'teacher from Poland')
    Post.create(title: 'post1', text: 'text1', author: user)
    Post.create(title: 'post2', text: 'text2', author: user)
    visit "/users/#{user.id}/posts"
    click_on 'post1'
    expect(page).to have_content('post1')
  end
end
