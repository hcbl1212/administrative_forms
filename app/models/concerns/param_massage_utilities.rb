module ParamMassageUtilities
    extend ActiveSupport::Concern
    module ClassMethods
        #works with data selector that has 3 components
        def format_date(strong_params, attribute_name)
            #year, month, day
            [
                strong_params["#{attribute_name}(1i)"],
                self.pad_day_and_month_with_leading_zero(strong_params["#{attribute_name}(2i)"]),
                self.pad_day_and_month_with_leading_zero(strong_params["#{attribute_name}(3i)"])
            ].join('-')
        end

        def pad_day_and_month_with_leading_zero(day_or_month)
            '%02i' %  day_or_month
        end

    end
end
