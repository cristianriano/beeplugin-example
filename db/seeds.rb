# frozen_string_literal: true

TEMPLATES_URL = 'https://rsrc.getbee.io/api/templates/'

%w[
  one-column
  promo
  newsletter
  m-bee
  base-one-column
  base-m-bee
  base-newsletter
  base-promo
].each do |name|
  template = Net::HTTP.get(URI(TEMPLATES_URL + name))
  next puts "Can't import #{name}" unless template.present?

  BeeTemplate.upsert(
    {
      name: name,
      content: template
    },
    unique_by: :name
  )
  print '.'
end
