class Task
  attr_accessor :id, :body, :field, :completed
  def initialize(id, body, field, completed)
    @id = id
    @body = body
    @field = field
    @completed = completed
  end

  def to_json(_ = nil)
    {
      id: id,
      body: body,
      field: field
    }.to_json
  end

  def completed?
    @completed = false
  end
end
