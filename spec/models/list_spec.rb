require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'marks all tasks from the list as complete' do
      list = List.create(name: "chores")
      Task.create(complete: false, list_id: list.id, name: "clean the toilet")
      Task.create(complete: false, list_id: list.id, name: "dump the milk")
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'snoozes all tasks\' deadlines' do
      list = List.create(name: "emergency")
      local_time = Time.now
      Task.create(complete: false, deadline: local_time, name: "clean the toilet")
      Task.create(complete: false, deadline: local_time, name: "dump the milk")
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(local_time + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'returns the total duration of all the tasks in the list' do
      list = List.create(name: "emergency")
      Task.create(list_id: list.id, duration: 60, name: "clean the toilet")
      Task.create(list_id: list.id, duration: 30, name: "dump the milk")
      expect(list.total_duration).to eq(90)
    end
  end

  describe '#incomplete_tasks' do
    it 'returns all the incomplte tasks in an array' do
      list = List.create(name: "emergency")
      Task.create(list_id: list.id, complete: true, name: "clean the toilet")
      Task.create(list_id: list.id, complete: false, name: "dump the milk")
      Task.create(list_id: list.id, complete: false, name: "drink the juice")
      Task.create(list_id: list.id, complete: false, name: "flip the case")
      tasks = Task.all.select { |task| task.complete == false }
      expect(list.incomplete_tasks).to match(tasks)

    end
  end

  describe '#favorite_tasks' do
    it 'returns all the favorite tasks in an array' do
      list = List.create(name: "emergency")
      Task.create(list_id: list.id, favorite: true, name: "clean the toilet")
      Task.create(list_id: list.id, favorite: true, name: "dump the milk")
      Task.create(list_id: list.id, favorite: true, name: "drink the juice")
      Task.create(list_id: list.id, favorite: false, name: "flip the case")
      tasks = Task.all.select { |task| task.favorite == true }
      expect(list.favorite_tasks).to eq(tasks)
    end
  end
end
