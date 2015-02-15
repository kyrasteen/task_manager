require_relative '../test_helper'

class TaskManagerTest < ModelTest
  def test_it_creates_a_task
    # can use symbols here because Sinatra allows string/symol interchangably
    TaskManager.create({ :title       => "a title",
                         :description => "a description",
                         })
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def create_three_tasks
    id_num = 1
    3.times do |task|
      TaskManager.create({ :title => "title #{id_num}", :description => "descr #{id_num}"})
      id_num += 1
    end
  end

  def test_it_can_find_single_task
    create_three_tasks
    task = TaskManager.find(2)
    assert_equal "title 2", task.title
    assert_equal "descr 2", task.description
  end

  def test_it_makes_all_task_objects
    create_three_tasks
    assert_equal 3, TaskManager.all.count
    assert_equal 'title 3', TaskManager.all.last[:title]
  end

  def test_it_updates_task
    create_three_tasks
    assert_equal "title 1", TaskManager.all.first[:title]
    TaskManager.update(1, { :title => "title beep", :description => "deer" })
    assert_equal "deer", TaskManager.all.first[:description]
  end

  def test_it_deletes_one_task
    create_three_tasks
    assert_equal 3, TaskManager.all.count
    TaskManager.delete(2)
    assert_equal 2, TaskManager.all.length
    assert_equal 3, TaskManager.all.last[:id]
    assert_equal 1, TaskManager.all.first[:id]
  end
end
