module ApplicationHelper

  ALLOW_TAGS = %W(string em b i p code pre tt br div span h1 h2 h3 h4 h5 h6 u ul ol
                  li dl dt dd abbr a img blockquote del table tr td tbody th strike hr)
  ALLOW_ATTRIBUTES = %w(href src width height title class name abbr id alt target rel data-floor style)
  EMPTY_STRING = ''.freeze

  def sanitize_markdown(body)
    sanitize(body, tags: ALLOW_TAGS, attributes: ALLOW_ATTRIBUTES)
  end

  # Override cache helper for support multiple I18n locale
  def cache(name = {}, options = {}, &block)
    options ||= {}
    super([I18n.locale, name], options, &block)
  end

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      text = content_tag(:div, link_to('x', '#', :class => 'close', 'data-dismiss' => 'alert') + message, class: "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def render_list(opts = {})
    list = []
    yield(list)
    items = []
    list.each do |link|
      item_class = EMPTY_STRING
      urls = link.match(/href=(["'])(.*?)(\1)/) || []
      url = urls.length > 2 ? urls[2] : nil
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = 'active'
      end
      items << content_tag('li', raw(link), class: item_class)
    end
    content_tag('ul', raw(items.join(EMPTY_STRING)), opts)
  end

  # 显示距当前之前的时间
  def timeago(time, options = {})
    options[:class] = options[:class].blank? ? 'timeago' : [options[:class], 'timeago'].join(' ')
    options.merge!(title: time.iso8601)
    content_tag(:abbr, EMPTY_STRING, class: options[:class], title: time.iso8601) if time
  end

  # Markdown格式转HTML
  def markdown(text)
    options = {
      :autolink => true,
      :space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :hard_warp => true,
      :strikethrough => true
    }

    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay, options)
    markdown.render(text)
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      language.downcase! if language.is_a?(String)

      # 当language未指定时，设置默认的
      language ||= :plaintext

      CodeRay.scan(code, language).div(:tab_width => 2)
    end
  end

end
