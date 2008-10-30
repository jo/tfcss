# Include hook code here
ActiveRecord::Base.send :include, Css
ActionView::Base.send :include, CssEditor
