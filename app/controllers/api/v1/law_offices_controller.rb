# frozen_string_literal: true

class Api::V1::LawOfficesController < ApplicationController
  skip_before_action :authenticate

  def index
    law_offices = LawOffice.includes(:translations)

    render json: law_offices.map { |o|
      translations = o.translations.each_with_object({}) do |tr, h|
        h[tr.locale.to_sym] = {
          name: tr.name,
          address: tr.address,
          description: tr.description
        }
      end

      {
        id: o.id,
        phone: o.phone,
        email: o.email,
        latitude: o.latitude,
        longitude: o.longitude,
        translations: {
          ru: translations[:ru] || { name: '', address: '', description: '' },
          kk: translations[:kk] || { name: '', address: '', description: '' },
          en: translations[:en] || { name: '', address: '', description: '' }
        }
      }
    }
  end
end

