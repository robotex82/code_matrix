ActiveAdmin.register Project do
  index do
    selectable_column
    id_column
    column :github_name
    
    column(:github_status)   { |p| link_to(t('active_admin.view'), p.github_human_url) if p.github_human_url }
    column(:rubygems_status) { |p| link_to(t('active_admin.view'), p.rubygems_human_url) if p.rubygems_human_url }
    column(:travis_status) { |p| link_to(image_tag(p.travis_badge_url), p.travis_human_url) if p.travis_human_url }
    
    column :created_at
    column :updated_at
    default_actions
  end
  
  show do
    attributes_table do
      row :id
      row :github_name
      row :created_at
      row :updated_at
    end
    
    panel 'details' do
      attributes_table_for project do
        row :github_details do |p|
          div(:class => 'jsonreport', :id => 'github_details') { p.github_details }
          script { "document.getElementById('github_details').innerHTML = _.jsonreport('#{p.github_details.body}');".html_safe }
        end
        row :rubygems_details do |p|
          div(:class => 'jsonreport', :id => 'rubygems_details') { p.rubygems_details }
          script { "document.getElementById('rubygems_details').innerHTML = _.jsonreport('#{p.rubygems_details.body}');".html_safe }
        end
        row :travis_ci_details do |p|
          div(:class => 'jsonreport', :id => 'travis_details') { p.travis_details.body.gsub(/\\n/, '\\\\\n') }
          script { "document.getElementById('travis_details').innerHTML = _.jsonreport('#{p.travis_details.body.gsub(/\\n/, '\\\\\n')}');".html_safe }
        end
      end
    end
    
    panel 'Readme' do
      # div { raw project.github_readme.to_html }
      div { raw RDoc::Markup.new.convert(project.github_readme, RDocWithHyperlinkToHtml.new) }
    end    
  end
end
