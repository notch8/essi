module Hyrax
  module My
    class M3ProfilesController < Hyrax::MyController
      before_action do
        authorize! :manage, M3Profile
      end

      def index
        add_breadcrumb t(:'hyrax.controls.home'), root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb t(:'hyrax.admin.sidebar.m3_profiles'), hyrax.my_m3_profiles_path
        super
      end
    end
  end
end
