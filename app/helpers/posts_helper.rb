module PostsHelper

  # Generates a link with a class of 'permalink' and an infinite symbol as 
  # it's text to the post
  def permalink_to(post)
    link_to(
      raw("&infin;"),
      post_path(post),
      :class => "permalink",
      :title => "Permanent link to this post."
    )
  end

  # Returns a date in the format: 6 Apr
  def date_for(date)
    content_tag :time do
      date.strftime("%e %b")
    end
  end

  # Generates links for editing and deleting a post
  def manage_links_for(post)
    if signed_in?
      content_tag :div, :class => "manage" do
        link_to("e", edit_post_path(post)) +
        raw(" &middot; ") +
        link_to("d", post_path(post), :method => :delete, :confirm => "Are you sure?")
      end
    end
  end

  # Renders the partial for the post's type
  def template_for(post)
    render(
      :partial => "#{post.type.pluralize}/#{post.type}",
      :locals  => { :post => post }
    )
  end

  def atom_template_for(entry, post)
    render(
      :partial => "#{post.type.pluralize}/#{post.type}",
      :locals  => {
        :entry => entry,
        :post => post
      }
    )
  end

  # Renders the form fields partial for the post's type
  def form_fields_for(post, form)
    render(
      :partial => "#{post.type.pluralize}/form",
      :locals  => { :f => form }
    )
  end

  # Parses a block of text of the format:
  #
  #   Person A: Message one.
  #   Person B: Message two.
  #   Person A: Message three.
  #
  # Into this:
  #
  #   <li><span class="author">Person A:</span> Message one.</li>
  #   <li><span class="author">Person B:</span> Message two.</li>
  #   <li><span class="author">Person A:</span> Message three.</li>
  def parse_chat_for(post)
    post.body.gsub(/^.*$/i) { |line|
      content_tag :li do
        raw(line.gsub(/^\w+:/i) { |author|
          content_tag :span, :class => "author" do
            author
          end
        })
      end
    }
  end

end
