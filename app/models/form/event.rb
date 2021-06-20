class Form::Event < Event
    REGISTRABLE_ATTRIBUTES = %i(title description wages user_id start end limit deadline imageurl)

    has_many :event_applicants, class_name: 'Form::EventApplicant'
end
