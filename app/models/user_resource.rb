class UserResource
    include Alba::Resource

    root_key :user

    attributes :id, :name

    attribute :name_with_email do |resource|
        "#{resource.name}: #{resource.email}"
    end
end