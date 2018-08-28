# frozen_string_literal: true

class NavPresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def initialize(viewing_user: NullUser.new)
    @viewing_user = viewing_user
  end

  def html
    content_tag(
      :nav,
      inner_html,
      class: 'navbar',
      role: 'navigation',
      'aria-label': 'main navigation'
    ).html_safe
  end

  private

  attr_reader :viewing_user

  def inner_html
    content_tag(:div, links, class: 'navbar-brand')
  end

  def learn_link
    link_to(
      'Learn',
      lines_read_path(id: viewing_user.next_line_to_learn),
      class: 'navbar-item'
    )
  end

  def links
    [root_link, learn_link, review_link, settings_link, sign_out_link, sign_up_link, sign_in_link].compact.join.html_safe
  end

  def review_link
    link_to(
      "Review (#{viewing_user.review_count})",
      lines_read_path(id: viewing_user.next_line_to_review),
      class: 'navbar-item',
      disabled: viewing_user.next_line_to_review.nil?
    )
  end

  def root_link
    link_to('MemorizeOnline', root_path, class: 'navbar-item')
  end

  def settings_link
    return unless viewing_user.persisted?
    link_to('Settings', user_path(viewing_user), class: 'navbar-item')
  end

  def sign_in_link
    return if viewing_user.persisted?
    link_to('Sign In', new_session_path, class: 'navbar-item')
  end

  def sign_out_link
    return unless viewing_user.persisted?
    link_to(
      'Sign Out',
      session_path(viewing_user),
      method: :delete,
      class: 'navbar-item'
    )
  end

  def sign_up_link
    return if viewing_user.persisted?
    link_to('Sign Up', new_user_path, class: 'navbar-item')
  end
end
