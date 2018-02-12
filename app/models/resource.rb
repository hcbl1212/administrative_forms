class Resource < ApplicationRecord
    enum resource_type: {
        pdf_document: 1
    }
end
