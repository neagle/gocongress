Gocongress::Application.routes.draw do

  # TODO: Find a permanent home for these authorize.net routes
  match '/payments/new', :to => 'payments#new', :as => 'new_payment', :via => [:get]
  match '/payments/relay_response', :to => 'payments#relay_response', :as => 'payments_relay_response', :via => [:post]
  match '/payments/receipt', :to => 'payments#receipt', :as => 'payments_receipt', :via => [:get]

  # Put the root route at the top so that it is matched quickly
  root :to => "home#index", :via => :get

  # It's time to get strict about format.  If someone requests a .php,
  # that's a 404!  I'd like to add :format => false to all my routes,
  # but it makes my routes file way too ugly, even if I use
  # with_options().  This constraint has the same effect.
  constraints :format => // do

    get "home/access_denied"

    # kaboom is an intentional error to test runtime exception notification
    get "home/kaboom"

    # these routes support multiple years with a year scope
    scope ":year" do

      # :year must be numeric
      constraints :year => /\d+/ do

        get 'edit' => 'years#edit', :as => :edit_year
        patch '' => 'years#update', :as => :update_year

        get 'costs' => 'plan_categories#index'

        devise_for :users,
          :controllers => { :registrations => "sign_ups" },
          :path => 'sign_ups'

        resources :activities, :contacts, :content_categories,
          :contents, :activity_categories, :tournaments,
          :transactions
        resources :plans, :except => [:index]
        resources :plan_categories do
          put 'update_order', :on => :collection
        end
        resources :shirts, :except => :show

        # Creating and updating attendees involves a few different
        # models, not just Attendee, so it's handled by the
        # registrations controller.
        resources :registrations, :except => [:show, :destroy]
        resources :attendees, :only => [:index] do
          collection do
            get 'list'
            get 'vip'
          end
          member do
            get 'print_summary', :as => 'print_summary_for'
          end
        end

        resources :users, :except => :destroy do
          member do
            get 'edit_email', :as => 'edit_email_for'
            get 'edit_password', :as => 'edit_password_for'
            get 'invoice'
            get 'ledger'
            get 'pay'
            get 'print_cost_summary', :as => 'print_cost_summary_for'
            patch 'cancel_attendee'
            patch 'restore_attendee'
            patch 'update_attendee_cancelled'
          end
          resource :terminus, :only => :show
        end

        # The reports_controller is deprecated, except for the index
        # action.  Use the rpt namespace below.
        resources :reports, :only => :index do
          collection do
            get :atn_reg_sheets,
              :emails, :activities, :invoices,
              :user_invoices
          end
        end

        # The "rpt" namespace has one controller for each report.
        # This replaces the deprecated reports_controller.
        namespace :rpt do
          resource :attendeeless_user_report, :only => :show
          resource :outstanding_balance_report, :only => :show
          resource :minor_agreements_report, :only => :show

          # These reports support CSV format
          constraints :format => /(csv)?/ do
            resource :attendee_report, :only => :show
            resource :cost_summary_report, :only => :show
            resource :daily_plan_details_report, :only => :show
            resource :daily_plan_report, :only => :show
            resource :transaction_report, :only => :show
          end

          constraints :format => /(xml)?/ do
            resource :usopen_players_report, :only => :show
          end
        end

        # This route provides `year_path`, so it's not defunct,
        # but perhaps it can be combined with the other `root`
        # at the top of the file?
        root :to => 'home#index', :as => :year, :via => :get

      end # end constraint
    end # end scope
  end # end constraint

end
