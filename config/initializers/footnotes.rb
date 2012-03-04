if Rails.env.development?
  Footnotes::Filter.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'
end
