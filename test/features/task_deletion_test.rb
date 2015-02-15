require_relative '../test_helper'

class TaskDeletionTest < FeatureTest

  def test_user_deletes_a_task
    TaskManager.create({'title'=> 'first title', 'description'=> 'first description'})
      visit '/tasks'
      click_link_or_button("delete")
      within('.task-list') do
        refute page.has_content?("first title")
      end
      assert_equal '/tasks', current_path
      assert_equal 0,TaskManager.all.count
  end

end
