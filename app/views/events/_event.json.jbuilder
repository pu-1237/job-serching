json.array! @works do |work|
    json.id work.id
    json.title work.title
    json.start work.start
    json.end work.end
end