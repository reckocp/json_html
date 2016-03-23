class Router
  def initialize(request)
    @request = request
  end

  def route
    [
      delete('/tasks/:id', TasksController, :destroy),
      put('/tasks/:id', TasksController, :update),
      get('/tasks/new', TasksController, :new),
      get('/tasks/:id', TasksController, :show),
      get('/tasks', TasksController, :index),
      post('/tasks', TasksController, :create)
    ].find(&:itself)
  end

  private # No need to edit these, but feel free to read them to see how they work

  def get(url_str, resource, action)
    if get? && route_match?(url_str)
      send_to_controller(resource, action)
    end
  end

  def post(url_str, resource, action)
    if post? && route_match?(url_str)
      send_to_controller(resource, action)
    end
  end

  def put(url_str, resource, action)
    if put? && route_match?(url_str)
      send_to_controller(resource, action)
    end
  end

  def delete(url_str, resource, action)
    if delete? && route_match?(url_str)
      send_to_controller(resource, action)
    end
  end

  def get?
    @request[:method] == "GET"
  end

  def put?
    @request[:method] == "PUT"
  end

  def post?
    @request[:method] == "POST"
  end

  def delete?
    @request[:method] == "DELETE"
  end

  def send_to_controller(resource, action)
    @request[:params].merge!({
      controller_name: resource.to_s,
      action_name: action
    })
    resource.new(@request).send(action)
  end

  def route_match?(url)
    @request[:route] =~ Regexp.new("^#{url.gsub(/:.+?[\w(\/.+)]/, '(.+)\1')}$")
  end
end
