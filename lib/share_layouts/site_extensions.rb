module ShareLayouts::SiteExtensions

  def layout_for(area = :public)
    default = Radiant::Config["#{area}.layout"]
    if self.respond_to?("#{area}_layout") && associated_layout = self.send("#{area}_layout".intern)
      associated_layout.name
    elsif configured_layout = Layout.find_by_name(Radiant::Config["#{area}.layout"])
      configured_layout.name
    elsif named_layout = Layout.find_by_name(area.to_s)
      named_layout.name
    elsif default_layout = self.default_layout
      default_layout.name
    else
      Layout.first.name
    end
  end

end

