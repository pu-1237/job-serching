Rack::Attack.throttle('limit logins per email', limit: 6, period: 60) do |req|
    if req.path == '/login' && req.post?
        req.params['email']
    end
end