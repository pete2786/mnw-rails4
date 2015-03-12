module ApplicationHelper

  def hide_if(boolean)
    boolean ? "display: none;" : ""
  end
end
