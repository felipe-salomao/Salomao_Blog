class ProcessPostJob < ApplicationJob
  queue_as :default

  def perform(user_id, file_path, category_id)
    user = User.find(user_id)
    file = File.open(file_path)

    file.each_line do |line|
      title, description = line.chomp.split('|')
      user.posts.create!(title: title, description: description, category_id: category_id)
    end

    File.delete(file_path)
  end
end
