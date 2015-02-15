require_relative '../test_helper'

class TaskEditingTest < FeatureTest

  def test_user_edits_a_task
    TaskManager.create({'title'=> 'first title', 'description'=> 'first description'})
      visit '/tasks'
      click_link_or_button("Edit")
      within('#edit') do
        assert page.has_content?("Edit")
      end
      fill_in 'task[title]',with: 'Run'
      fill_in 'task[description]',with: 'and stretch'
      click_link_or_button('Update')
      assert_equal '/tasks/1', current_path
      within('.link-index') do
        assert page.has_content?("back to all tasks")
      end
  end

end
