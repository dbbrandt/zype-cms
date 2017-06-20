class HomePage < Fae::StaticPage

  @slug = 'home'

  # required to set the has_one associations, Fae::StaticPage will build these associations dynamically
  def self.fae_fields
    {
      featured_video: { type: Fae::TextField },
      feature_description: { type: Fae::TextField },
      title: { type: Fae::TextField },
      body: { type: Fae::TextArea },
      subscribe_link: { type: Fae::TextField }
    }
  end

end
