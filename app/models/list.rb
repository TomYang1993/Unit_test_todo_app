class List < ActiveRecord::Base
  has_many :tasks

  def complete_all_tasks!
    tasks.update_all(complete: true)
    # optimized code, less database queries
    # tasks.each do |task|
    #   task.update(complete: true)
    # end
  end

  def snooze_all_tasks!
    tasks.each { |task| task.snooze_hour! }
  end

  def total_duration
    sum = tasks.inject(0) { |sum, task| sum + task.duration }
    return sum
    # total = 0
    # tasks.each do |task|
    #   total += task.duration
    # end
    # return total
  end

  def incomplete_tasks
    return tasks.select { |task| task.complete == false }
    # array_of_tasks = []
    # tasks.each do |task|
    #   if !task.complete
    #     array_of_tasks << task
    #   end
    # end
    # return array_of_tasks
  end

  def favorite_tasks
    tasks.where(favorite: true)
    # return tasks.select { |task| task.favorite == true }
  end
end
