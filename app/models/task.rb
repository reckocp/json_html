class Task
  attr_accessor :id, :body, :completed
  def initialize(id, body, completed)
    @id = id
    @body = body
    @completed = completed
  end

  def to_json(_ = nil)
    {
      id: id,
      body: body
    }.to_json
  end

  def completed?
    @completed == true
  end
end
