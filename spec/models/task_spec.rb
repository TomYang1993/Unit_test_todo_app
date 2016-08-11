require 'rails_helper'

RSpec.describe Task, type: :model do
  
  describe '#toggle_favorite!' do
    it 'switches the state of favorite(switch favorite to true if it is false) ' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'should over the deadline (returns false deadline is before now!!)' do
      task = Task.new
      task.deadline = Time.now + 1.minute
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'should catch the deadline ' do
      task = Task.new(deadline: Time.now - 1.minute)
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority!' do
    it 'should increment the priority when priority is less than 10 ' do
      task = Task.new(priority: 7)
      task.increment_priority!
      expect(task.priority).to eq(8)
    end
  end

  describe '#increment_priority!' do
    it 'should do nothing when priority is 10 ' do
      priority = 10
      task = Task.new(priority: priority)
      task.increment_priority!
      expect(task.priority).to eq(priority)
    end
  end

  describe '#snooze_hour!' do
    it 'delay deadline for one hour ' do
      deadline = Time.now
      task = Task.new(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end
