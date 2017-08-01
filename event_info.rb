class EventInfo
  attr_reader :title,:description,:venue
  def initialize(title,description="",venue="")
  	@title = title
  	@description = description
  	@venue = venue
  end
end

