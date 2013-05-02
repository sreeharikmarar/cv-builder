module ApplicationHelper
  def find_feed_class(index)
    if index >= 1
      "multy-feed"
    else
      "single-fluid"
    end
  end
end
