ActiveAdmin.register Project do
      show :title => :title do
      panel "Tasks" do
        table_for project.tasks do |t|
          t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
          t.column("Title") { |task| link_to task.title, admin_task_path(task) }
          t.column("Assigned To") { |task| task.admin_user.email }
          t.column("Due Date") { |task| task.due_date? ? l(task.due_date, :format => :long) : '-' }
        end
      end
    end
end
