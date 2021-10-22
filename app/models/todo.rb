
class Todo < ActiveRecord::Base
  def due_today?
    date_due == Date.today
  end

  def self.overdue
    where("date_due < ?", Date.today)
  end

  def self.due_today
    where(date_due: Date.today)
  end

  def self.due_later
    where("date_due > ?", Date.today)
  end

  def self.work_done
    where(work_done: true)
  end

  def to_displayable_string
    status_display = work_done ? "[X]" : "[ ]"
    show_date = due_today? ? nil : date_due
    "#{id}. #{status_display} #{todo_item_text} #{show_date}"
  end

  def self.show_list
    puts "My Todo list\n\n"

    puts "OverDue\n"
    puts overdue.map { |todo_item| todo_item.to_displayable_string }
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.map { |todo_item| todo_item.to_displayable_string }
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.map { |todo_item| todo_item.to_displayable_string }
    puts "\n\n"
  end

  def self.add_task(todo_item)
    todo_item_text = todo_item[:todo_item_text]
    date_due = Date.today + todo_item[:due_in_days]
    create!(todo_item_text: todo_item_text, date_due: date_due, work_done: false)
  end

  def self.mark_as_complete(todo_item_id)
    todo_item_for_completion = find(todo_item_id)
    todo_item_for_completion.work_done = true
    todo_item_for_completion.save
    return todo_item_for_completion
  end
end
