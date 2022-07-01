module Visible
    extend ActiveSupport::Concern

    VALID_STATUSES = ['public', 'private', 'archived']

    included do
        validates :status, inclusion: { in: VALID_STATUSES, message: "%{value} is unvalid"}
    end

    class_methods do
        def public_count
            where(status: 'public').count
        end
    end

    # インスタンスメソッドも、includeしたら使える
    def tesp2
        p '2'
    end

end