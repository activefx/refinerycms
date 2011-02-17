# DO NOT EDIT THIS FILE DIRECTLY! Instead, use lib/gemspec.rb to generate it.

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-core}
  s.version           = %q{0.9.9.3}
  s.summary           = %q{Core engine for Refinery CMS}
  s.description       = %q{The core of Refinery CMS. This handles the common functionality and is required by most engines}
  s.date              = %q{2011-02-17}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://refinerycms.com}
  s.rubyforge_project = %q{refinerycms}
  s.authors           = ['Resolve Digital', 'Philip Arndt', 'David Jones', 'Steven Heidel']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)
  s.executables       = %w()

  s.add_dependency 'refinerycms-base',            '~> 0.9.9.3'
  s.add_dependency 'refinerycms-settings',        '~> 0.9.9.3'
  s.add_dependency 'refinerycms-generators',      '~> 0.9.9.3'
  s.add_dependency 'acts_as_indexed',             '~> 0.7'
  s.add_dependency 'friendly_id_globalize3',      '~> 3.2.0'
  s.add_dependency 'globalize3',                  '>= 0.1.0.beta'
  s.add_dependency 'moretea-awesome_nested_set',  '= 1.4.3.1'
  s.add_dependency 'rails',                       '~> 3.0.3'
  s.add_dependency 'rdoc',                        '>= 2.5.11' # helps fix ubuntu
  s.add_dependency 'truncate_html',               '~> 0.5'
  s.add_dependency 'will_paginate',               '~> 3.0.pre'

  s.files             = [
    'app',
    'app/controllers',
    'app/controllers/admin',
    'app/controllers/admin/base_controller.rb',
    'app/controllers/admin/dialogs_controller.rb',
    'app/controllers/admin/refinery_core_controller.rb',
    'app/controllers/application_controller.rb',
    'app/controllers/refinery',
    'app/controllers/refinery/fast_controller.rb',
    'app/controllers/sitemap_controller.rb',
    'app/helpers',
    'app/helpers/application_helper.rb',
    'app/views',
    'app/views/admin',
    'app/views/admin/_head.html.erb',
    'app/views/admin/_javascripts.html.erb',
    'app/views/admin/_menu.html.erb',
    'app/views/admin/dialogs',
    'app/views/admin/dialogs/show.html.erb',
    'app/views/layouts',
    'app/views/layouts/admin.html.erb',
    'app/views/layouts/admin_dialog.html.erb',
    'app/views/layouts/application.html.erb',
    'app/views/shared',
    'app/views/shared/_content_page.html.erb',
    'app/views/shared/_draft_page_message.html.erb',
    'app/views/shared/_footer.html.erb',
    'app/views/shared/_google_analytics.html.erb',
    'app/views/shared/_head.html.erb',
    'app/views/shared/_header.html.erb',
    'app/views/shared/_html_tag.html.erb',
    'app/views/shared/_ie6check.html.erb',
    'app/views/shared/_javascripts.html.erb',
    'app/views/shared/_menu.html.erb',
    'app/views/shared/_menu_branch.html.erb',
    'app/views/shared/_message.html.erb',
    'app/views/shared/_no_script.html.erb',
    'app/views/shared/_site_bar.html.erb',
    'app/views/shared/admin',
    'app/views/shared/admin/_continue_editing.html.erb',
    'app/views/shared/admin/_error_messages.html.erb',
    'app/views/shared/admin/_form_actions.html.erb',
    'app/views/shared/admin/_image_picker.html.erb',
    'app/views/shared/admin/_make_sortable.html.erb',
    'app/views/shared/admin/_resource_picker.html.erb',
    'app/views/shared/admin/_search.html.erb',
    'app/views/shared/admin/_sortable_list.html.erb',
    'app/views/shared/admin/_tabbed_fields.html.erb',
    'app/views/welcome.html.erb',
    'app/views/wymiframe.html.erb',
    'config',
    'config/locales',
    'config/locales/cs.yml',
    'config/locales/da.yml',
    'config/locales/de.yml',
    'config/locales/el.yml',
    'config/locales/en.yml',
    'config/locales/es.yml',
    'config/locales/fr.yml',
    'config/locales/it.yml',
    'config/locales/lolcat.yml',
    'config/locales/lt.yml',
    'config/locales/lv.yml',
    'config/locales/nb.yml',
    'config/locales/nl.yml',
    'config/locales/pl.yml',
    'config/locales/pt-BR.yml',
    'config/locales/rs.yml',
    'config/locales/ru.yml',
    'config/locales/sl.yml',
    'config/locales/sv.yml',
    'config/locales/vi.yml',
    'config/locales/zh-CN.yml',
    'config/locales/zh-TW.yml',
    'config/routes.rb',
    'crud.md',
    'doc',
    'doc/included-jquery-ui-packages.jpg',
    'engines.md',
    'features',
    'features/search.feature',
    'features/site_bar.feature',
    'features/step_definitions',
    'features/step_definitions/core_steps.rb',
    'features/support',
    'features/support/paths.rb',
    'features/uploads',
    'features/uploads/beach.jpeg',
    'features/uploads/refinery_is_awesome.txt',
    'lib',
    'lib/gemspec.rb',
    'lib/generators',
    'lib/generators/refinerycms_generator.rb',
    'lib/generators/templates',
    'lib/generators/templates/.gitignore',
    'lib/generators/templates/app',
    'lib/generators/templates/app/views',
    'lib/generators/templates/app/views/sitemap',
    'lib/generators/templates/app/views/sitemap/index.xml.builder',
    'lib/generators/templates/autotest',
    'lib/generators/templates/autotest/autotest.rb',
    'lib/generators/templates/autotest/discover.rb',
    'lib/generators/templates/config',
    'lib/generators/templates/config/database.yml.mysql',
    'lib/generators/templates/config/database.yml.postgresql',
    'lib/generators/templates/config/database.yml.sqlite3',
    'lib/generators/templates/config/i18n-js.yml',
    'lib/generators/templates/config/initializers',
    'lib/generators/templates/config/initializers/devise.rb',
    'lib/generators/templates/config/settings.rb',
    'lib/generators/templates/db',
    'lib/generators/templates/db/seeds.rb',
    'lib/refinery',
    'lib/refinery/activity.rb',
    'lib/refinery/admin',
    'lib/refinery/admin/base_controller.rb',
    'lib/refinery/admin_base_controller.rb',
    'lib/refinery/application.rb',
    'lib/refinery/application_controller.rb',
    'lib/refinery/application_helper.rb',
    'lib/refinery/base_presenter.rb',
    'lib/refinery/catch_all_routes.rb',
    'lib/refinery/crud.rb',
    'lib/refinery/helpers',
    'lib/refinery/helpers/form_helper.rb',
    'lib/refinery/helpers/head_helper.rb',
    'lib/refinery/helpers/html_truncation_helper.rb',
    'lib/refinery/helpers/image_helper.rb',
    'lib/refinery/helpers/menu_helper.rb',
    'lib/refinery/helpers/meta_helper.rb',
    'lib/refinery/helpers/pagination_helper.rb',
    'lib/refinery/helpers/script_helper.rb',
    'lib/refinery/helpers/site_bar_helper.rb',
    'lib/refinery/helpers/tag_helper.rb',
    'lib/refinery/helpers/translation_helper.rb',
    'lib/refinery/link_renderer.rb',
    'lib/refinery/plugin.rb',
    'lib/refinery/plugins.rb',
    'lib/refinerycms-core.rb',
    'lib/tasks',
    'lib/tasks/doc.rake',
    'lib/tasks/refinery.rake',
    'lib/tasks/yard.rake',
    'license.md',
    'public',
    'public/404.html',
    'public/422.html',
    'public/500.html',
    'public/favicon.ico',
    'public/images',
    'public/images/refinery',
    'public/images/refinery/add.png',
    'public/images/refinery/admin_bg.png',
    'public/images/refinery/ajax-loader.gif',
    'public/images/refinery/branch-end.gif',
    'public/images/refinery/branch-start.gif',
    'public/images/refinery/branch.gif',
    'public/images/refinery/carousel-left.png',
    'public/images/refinery/carousel-right.png',
    'public/images/refinery/cross.png',
    'public/images/refinery/dialogLoadingAnimation.gif',
    'public/images/refinery/header_background.png',
    'public/images/refinery/hover-gradient.jpg',
    'public/images/refinery/icons',
    'public/images/refinery/icons/accept.png',
    'public/images/refinery/icons/add.png',
    'public/images/refinery/icons/ajax-loader.gif',
    'public/images/refinery/icons/application_edit.png',
    'public/images/refinery/icons/application_go.png',
    'public/images/refinery/icons/arrow_left.png',
    'public/images/refinery/icons/arrow_switch.png',
    'public/images/refinery/icons/arrow_up.png',
    'public/images/refinery/icons/bin.png',
    'public/images/refinery/icons/bin_closed.png',
    'public/images/refinery/icons/cancel.png',
    'public/images/refinery/icons/cog_add.png',
    'public/images/refinery/icons/cog_edit.png',
    'public/images/refinery/icons/cross.png',
    'public/images/refinery/icons/delete.png',
    'public/images/refinery/icons/doc.png',
    'public/images/refinery/icons/down.gif',
    'public/images/refinery/icons/edit.png',
    'public/images/refinery/icons/email.png',
    'public/images/refinery/icons/email_edit.png',
    'public/images/refinery/icons/email_go.png',
    'public/images/refinery/icons/email_open.png',
    'public/images/refinery/icons/eye.png',
    'public/images/refinery/icons/folder_page_white.png',
    'public/images/refinery/icons/image_add.png',
    'public/images/refinery/icons/image_edit.png',
    'public/images/refinery/icons/img.png',
    'public/images/refinery/icons/information.png',
    'public/images/refinery/icons/layout_add.png',
    'public/images/refinery/icons/layout_edit.png',
    'public/images/refinery/icons/music.png',
    'public/images/refinery/icons/page_add.png',
    'public/images/refinery/icons/page_edit.png',
    'public/images/refinery/icons/page_white_edit.png',
    'public/images/refinery/icons/page_white_gear.png',
    'public/images/refinery/icons/page_white_put.png',
    'public/images/refinery/icons/pdf.png',
    'public/images/refinery/icons/ppt.png',
    'public/images/refinery/icons/star.png',
    'public/images/refinery/icons/tick.png',
    'public/images/refinery/icons/up.gif',
    'public/images/refinery/icons/user_add.png',
    'public/images/refinery/icons/user_comment.png',
    'public/images/refinery/icons/user_edit.png',
    'public/images/refinery/icons/xls.png',
    'public/images/refinery/icons/zip.png',
    'public/images/refinery/icons/zoom.png',
    'public/images/refinery/logo-large.png',
    'public/images/refinery/logo-medium.png',
    'public/images/refinery/logo-site-bar.png',
    'public/images/refinery/logo-small-medium.png',
    'public/images/refinery/logo-small.png',
    'public/images/refinery/logo-tiny.png',
    'public/images/refinery/logo.png',
    'public/images/refinery/nav-3-background.gif',
    'public/images/refinery/nav_inactive_background.png',
    'public/images/refinery/orange_button.png',
    'public/images/refinery/page_bg.png',
    'public/images/refinery/resolve_digital_footer_logo.png',
    'public/images/refinery/text_field_background.png',
    'public/images/refinery/tooltip-nib.gif',
    'public/images/refinery/tooltip-nib.png',
    'public/images/wymeditor',
    'public/images/wymeditor/skins',
    'public/images/wymeditor/skins/refinery',
    'public/images/wymeditor/skins/refinery/arrow_redo.png',
    'public/images/wymeditor/skins/refinery/arrow_undo.png',
    'public/images/wymeditor/skins/refinery/eye.png',
    'public/images/wymeditor/skins/refinery/iframe',
    'public/images/wymeditor/skins/refinery/iframe/lbl-blockquote.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-h1.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-h2.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-h3.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-h4.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-h5.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-h6.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-p.png',
    'public/images/wymeditor/skins/refinery/iframe/lbl-pre.png',
    'public/images/wymeditor/skins/refinery/link_add.png',
    'public/images/wymeditor/skins/refinery/link_break.png',
    'public/images/wymeditor/skins/refinery/page_code.png',
    'public/images/wymeditor/skins/refinery/page_paste.png',
    'public/images/wymeditor/skins/refinery/photo_add.png',
    'public/images/wymeditor/skins/refinery/right.png',
    'public/images/wymeditor/skins/refinery/style.png',
    'public/images/wymeditor/skins/refinery/table_add.png',
    'public/images/wymeditor/skins/refinery/text_align_center.png',
    'public/images/wymeditor/skins/refinery/text_align_justify.png',
    'public/images/wymeditor/skins/refinery/text_align_left.png',
    'public/images/wymeditor/skins/refinery/text_align_right.png',
    'public/images/wymeditor/skins/refinery/text_bold.png',
    'public/images/wymeditor/skins/refinery/text_heading_1.png',
    'public/images/wymeditor/skins/refinery/text_heading_2.png',
    'public/images/wymeditor/skins/refinery/text_heading_3.png',
    'public/images/wymeditor/skins/refinery/text_heading_4.png',
    'public/images/wymeditor/skins/refinery/text_heading_5.png',
    'public/images/wymeditor/skins/refinery/text_heading_6.png',
    'public/images/wymeditor/skins/refinery/text_indent.png',
    'public/images/wymeditor/skins/refinery/text_indent_remove.png',
    'public/images/wymeditor/skins/refinery/text_italic.png',
    'public/images/wymeditor/skins/refinery/text_list_bullets.png',
    'public/images/wymeditor/skins/refinery/text_list_numbers.png',
    'public/images/wymeditor/skins/refinery/text_paragraph.png',
    'public/images/wymeditor/skins/refinery/text_strikethrough.png',
    'public/images/wymeditor/skins/refinery/text_subscript.png',
    'public/images/wymeditor/skins/refinery/text_superscript.png',
    'public/images/wymeditor/skins/refinery/text_underline.png',
    'public/images/wymeditor/skins/wymeditor_icon.png',
    'public/javascripts',
    'public/javascripts/admin.js',
    'public/javascripts/application.js',
    'public/javascripts/dd_belatedpng.js',
    'public/javascripts/i18n-messages.js',
    'public/javascripts/jquery',
    'public/javascripts/jquery/GPL-LICENSE.txt',
    'public/javascripts/jquery/MIT-LICENSE.txt',
    'public/javascripts/jquery/jquery.corner.js',
    'public/javascripts/jquery/jquery.html5-placeholder-shim.js',
    'public/javascripts/jquery/jquery.jcarousel.js',
    'public/javascripts/jquery/jquery.textTruncate.js',
    'public/javascripts/jquery/jquery.timers.js',
    'public/javascripts/jquery-min.js',
    'public/javascripts/jquery-ui-custom-min.js',
    'public/javascripts/jquery.js',
    'public/javascripts/modernizr-min.js',
    'public/javascripts/rails.js',
    'public/javascripts/refinery',
    'public/javascripts/refinery/admin.js',
    'public/javascripts/refinery/boot_wym.js',
    'public/javascripts/refinery/core.js',
    'public/javascripts/refinery/i18n.js',
    'public/javascripts/refinery/nestedsortables.js',
    'public/javascripts/refinery/serializelist.js',
    'public/javascripts/refinery/site_bar.js',
    'public/javascripts/refinery/submenu.js',
    'public/javascripts/wymeditor',
    'public/javascripts/wymeditor/jquery.refinery.wymeditor.js',
    'public/javascripts/wymeditor/lang',
    'public/javascripts/wymeditor/lang/ca.js',
    'public/javascripts/wymeditor/lang/cs.js',
    'public/javascripts/wymeditor/lang/da.js',
    'public/javascripts/wymeditor/lang/de.js',
    'public/javascripts/wymeditor/lang/en.js',
    'public/javascripts/wymeditor/lang/es.js',
    'public/javascripts/wymeditor/lang/fa.js',
    'public/javascripts/wymeditor/lang/fr.js',
    'public/javascripts/wymeditor/lang/he.js',
    'public/javascripts/wymeditor/lang/hu.js',
    'public/javascripts/wymeditor/lang/it.js',
    'public/javascripts/wymeditor/lang/lv.js',
    'public/javascripts/wymeditor/lang/nb.js',
    'public/javascripts/wymeditor/lang/nl.js',
    'public/javascripts/wymeditor/lang/nn.js',
    'public/javascripts/wymeditor/lang/pl.js',
    'public/javascripts/wymeditor/lang/pt-BR.js',
    'public/javascripts/wymeditor/lang/pt.js',
    'public/javascripts/wymeditor/lang/rs.js',
    'public/javascripts/wymeditor/lang/ru.js',
    'public/javascripts/wymeditor/lang/sl.js',
    'public/javascripts/wymeditor/lang/sv.js',
    'public/javascripts/wymeditor/lang/tr.js',
    'public/javascripts/wymeditor/lang/vi.js',
    'public/javascripts/wymeditor/lang/zh_cn.js',
    'public/javascripts/wymeditor/skins',
    'public/javascripts/wymeditor/skins/refinery',
    'public/javascripts/wymeditor/skins/refinery/skin.js',
    'public/robots.txt',
    'public/stylesheets',
    'public/stylesheets/application.css',
    'public/stylesheets/formatting.css',
    'public/stylesheets/home.css',
    'public/stylesheets/refinery',
    'public/stylesheets/refinery/application.css',
    'public/stylesheets/refinery/formatting.css',
    'public/stylesheets/refinery/home.css',
    'public/stylesheets/refinery/refinery.css',
    'public/stylesheets/refinery/site_bar.css',
    'public/stylesheets/refinery/submenu.css',
    'public/stylesheets/refinery/theme.css',
    'public/stylesheets/refinery/tooltips.css',
    'public/stylesheets/refinery/ui.css',
    'public/stylesheets/theme.css',
    'public/stylesheets/wymeditor',
    'public/stylesheets/wymeditor/skins',
    'public/stylesheets/wymeditor/skins/refinery',
    'public/stylesheets/wymeditor/skins/refinery/skin.css',
    'public/stylesheets/wymeditor/skins/refinery/wymiframe.css',
    'public/wymeditor',
    'public/wymeditor/GPL-license.txt',
    'public/wymeditor/MIT-license.txt',
    'public/wymeditor/README',
    'refinerycms-core.gemspec',
    'spec',
    'spec/lib',
    'spec/lib/refinery',
    'spec/lib/refinery/plugins_spec.rb'
  ]
end
