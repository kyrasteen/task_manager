require 'yaml/store'

class TaskManager

  def self.database
   if ENV["TASK_MANAGER_ENV"] == 'test'
     @database ||= Sequel.sqlite('db/task_manager_test.sqlite3')
    #  @database ||= YAML::Store.new("db/task_manager_test")
   else
     @database ||= Sequel.sqlite('db/task_manager_dev.sqlite3')
   end
 end

  def self.create(task)
    dataset.insert({ :title => task[:title], :description => task[:description]})
    # database.transaction do
    #   database['tasks'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['tasks'] << { "id" => database['total'], "title" => task[:title], "description" => task[:description] }
    # end
  end

  def self.dataset
    database[:tasks]
  end

  def self.raw_tasks
    dataset.to_a
    # database.transaction do
    #   database['tasks'] || []
    # end
  end

  def self.all
    raw_tasks
    # raw_tasks.map { |data| Task.new(data) }
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task[:id] == id }
  end

  def self.find(id)
    Task.new(raw_task(id))
  end

  def self.update(id, task)
    row = dataset.where(:id => id)
    row.update({:title => task[:title], :description => task[:description]})
  end

  def self.delete(id)
    dataset.where(:id => id).delete
    # database.transaction do
    #   database['tasks'].delete_if { |task| task["id"] == id }
    # end
  end

  def self.delete_all
    dataset.delete
    # database.transaction do
    #   database['tasks'] = []
    #   database['total'] = 0
    # end
  end

end
