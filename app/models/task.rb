class Task
  attr_accessor :id, :task, :field
  def initialize(id, task, field)
    @id = id
    @task = task
    @field = field
  end

  def to_json(_ = nil)
    {
      id: id,
      task: task,
      feild: field
    }.to_json
  end
end
