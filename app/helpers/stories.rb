helpers do
  def create_story
    if request.xhr?
      new_story = Story.create!(longitude: params[:longitude], latitude: params[:latitude])
      new_story.story_maker
      current_user.stories << new_story
      content_type :json
      new_story.to_json
    end
  end
end
