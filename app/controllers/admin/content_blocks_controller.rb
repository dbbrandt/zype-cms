module Admin
  class ContentBlocksController < Fae::StaticPagesController

    private

    def fae_pages
      [HomePage]
    end
  end
end
