class Form::EventApplicant < EventApplicant
    REGISTRABLE_ATTRIBUTES = %i(id applicant_id event_id request attendance begin finish _destroy)

    def selectable_categories
        Category.all
    end
end
