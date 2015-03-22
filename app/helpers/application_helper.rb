module ApplicationHelper

  def hide_if(boolean)
    boolean ? "display: none;" : ""
  end

  def signin_path
    "/auth/facebook"
  end
end
