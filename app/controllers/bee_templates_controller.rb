# frozen_string_literal: true

class BeeTemplatesController < ApplicationController
  AUTH_URI = URI('https://auth.getbee.io/apiauth')

  def new
    @template_path = bee_template_path(params['template_id'])
  end

  def create
    if upsert_template
      head :ok
    else
      head 400
    end
  end

  def index
    @templates = BeeTemplate.all
  end

  def show
    @template = BeeTemplate.find(params['id'].to_i)
    render json: @template.content
  end

  def token
    credentials = Rails.application.credentials.bee

    res = Net::HTTP.post_form(
      AUTH_URI,
      client_id: credentials[:client_id],
      client_secret: credentials[:client_secret]
    )

    render json: res.body
  end

  private

  def upsert_template
    BeeTemplate.upsert(
      { name: params['name'], content: params['template'] },
      unique_by: :name
    )
  end
end
