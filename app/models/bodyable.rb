##::TODO:: move this somewhere more appropriate 

module Bodyable
  def initialize(*args)
    super 
    self.body ||= RichText.new
  end

  def body_text
    self.body.text
  end

  def body_text=(str)
    self.body = RichText.new({text: str})
  end
end