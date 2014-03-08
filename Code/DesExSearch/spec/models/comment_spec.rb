# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer          default(0)
#  commentable_type :string(255)
#  title            :string(255)
#  body             :text
#  subject          :string(255)
#  user_id          :integer          default(0), not null
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Comment do
  before do
    @user = User.create(email: "comment@example.com", password: "comment123")
    @comment = Comment.new(body: "some text", user_id: @user.id)
  end

  subject { @comment }

  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:subject) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:lft) }
  it { should respond_to(:rgt) }
  it { should respond_to(:commentable_type) }
  it { should respond_to(:commentable_id) }

  describe "when body is not present" do
    before { @comment.body = "" }
    it {should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end

end