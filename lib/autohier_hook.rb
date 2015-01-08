module AutoHierHook
  class AutoHierHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :partial => 'hooks/html_header_ah'
    render_on :view_layouts_base_body_bottom, :partial => 'hooks/body_bottom_ah'
  end
end
