class GridfsController < ActionController::Metal

  def serve
    begin
      @image             = Image.find(params[:id]).image
      self.response_body = @image.read
      self.content_type  = @image.content_type
    rescue
      self.status        = :file_not_found
      self.content_type  = "text/plan"
      self.response_body = ""
    end
  end

end
