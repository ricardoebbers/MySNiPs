module Response
  def json_response(object, status=:ok)
    result = render json: object.as_json(except: :id), status: status
    # For easy testing
    puts "Response: " + result
    result
  end
end
