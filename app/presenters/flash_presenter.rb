# frozen_string_literal: true

class FlashPresenter
  include ActionView::Helpers

  def initialize(flash)
    @flash = flash
  end

  def html
    content_tag(:article, inner_html, class: 'message is-warning').html_safe
  end

  private

  attr_reader :flash

  def body
    content_tag(:div, flash.alert, class: 'message-body')
  end

  def delete_button
    content_tag(:button, '', class: 'delete', 'aria-label': 'delete')
  end

  def header
    content_tag(:div, header_interior, class: 'message-header')
  end

  def header_interior
    [warning, delete_button].join.html_safe
  end

  def inner_html
    [header, body].join.html_safe
  end

  def warning
    content_tag(:p, 'Warning')
  end
end
