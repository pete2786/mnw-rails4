module ApplicationHelper

  def hide_if(boolean)
    boolean ? "display: none;" : ""
  end

  def signin_path
    "/auth/facebook?origin=#{request.url}"
  end

  def link_to_or_siginin(name, path, options={})
    current_user ? link_to(name, path, options) : link_to(name, '#', signin_options.merge(options))
  end

  def link_to_or_signin_block(path, options={}, &block)
    current_user ? link_to(path, options){ block.call } : link_to(path, signin_options.merge(options)) { block.call }
  end

  def signin_options
    {
      "data-toggle": 'modal',
      "data-target": '#sign_in_modal',
      class: "sign_in_modal"
    }
  end

  def title(page_title)
    content_for(:title) { page_title.html_safe }
  end

  def app_name
    Rails.application.secrets.app_name
  end

  def conditions(current)
    content_for(:title) { "#{current.location}: #{current.temperature}&deg;".html_safe }
    content_for(:description) { "#{current.text} Find more humor in weather at #{app_name}." }
    content_for(:og_image) { current.phrase.image.url }
    content_for(:thumb) { current.phrase.image.thumb.url }
    content_for(:og_url) { current_condition_url(current) }
  end
end
