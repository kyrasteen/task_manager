require_relative '../test_helper'

class FrontPageTest < FeatureTest

  def test_user_sees_greeting
      visit '/'
      assert page.has_content?("Task Manager")
      within('.heading') do
        assert page.has_content?("Task Manager")
      end
  end

  def test_user_sees_index_and_new_links
    visit '/'
    assert page.has_content?("Task Index")
    assert page.has_css?('a')
    assert page.find_link('Task Index').visible?

    within('.nav') do
      assert page.has_content?("New Task")
    end

    within('.link') do
      assert page.has_content?("Task Index")
    end
  end

end
