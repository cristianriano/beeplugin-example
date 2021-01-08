# frozen_string_literal: true

class EditorController < ApplicationController
  AUTH_URI = URI('https://auth.getbee.io/apiauth')

  # Possible values for bee_template_url:
  #
  # one-column
  # promo
  # newsletter
  # m-bee
  # base-one-column
  # base-m-bee
  # base-newsletter
  # base-promo

  def index
    @template_url = bee_templates_url('m-bee')
  end

  def token
    credentials = Rails.application.credentials.bee

    res = Net::HTTP.post_form(
      AUTH_URI,
      grant_type: 'password',
      client_id: credentials[:client_id],
      client_secret: credentials[:client_secret]
    )

    render json: res.body
  end

  def bee_templates_url(id)
    "https://rsrc.getbee.io/api/templates/#{id}"
  end
end
