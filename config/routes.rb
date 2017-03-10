RedmineApp::Application.routes.draw do
  get 'autocomplete/mention/user' => 'auto_completes#autocomplete_mention_user'
end
