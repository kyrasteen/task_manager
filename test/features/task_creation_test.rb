require_relative '../test_helper'

class TaskCreationTest < FeatureTest

  def test_user_creates_a_task
      visit '/'
      click_link_or_button("New Task")
      assert_equal '/tasks/new', current_path
      fill_in 'task[title]',with: 'Run'
      fill_in 'task[description]',with: 'and stretch'
      click_link_or_button('create')
      assert_equal '/tasks', current_path
      within('.task-list') do
        assert page.has_content?("Run")
      end
  end

end
