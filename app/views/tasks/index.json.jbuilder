# json.array! @tasks, partial: "tasks/task", as: :task

json.set! :data do
  json.array! @tasks do |task|
    json.name "#{link_to task.name, task}"
    json.score "#{task.score}"
    json.description "#{task.description}"
    json.publicity "#{task.publicity}"
    json.url  "
              #{link_to '<i class="fas fa-edit"></i>'.html_safe, edit_task_path(task), style: 'color: grey'}
              #{link_to "<i class='far fa-trash-alt'></i>".html_safe, task, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, class:"mx-2", style: "color: red" if current_staff.admin? || current_staff.vip?}
              "
  end
end
