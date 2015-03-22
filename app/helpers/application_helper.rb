module ApplicationHelper

  def hide_if(boolean)
    boolean ? "display: none;" : ""
  end

  def signin_path
    "/auth/facebook?origin=#{request.url}"
  end

  def link_to_or_siginin(name, path)
    current_user ? link_to(name, path) : link_to(name, '#', "data-toggle": 'modal', "data-target": '#sign_in_modal')
  end
end
