module Hyrax
  module My
    class M3ProfilesController < Hyrax::MyController
      include Hyrax::ThemedLayoutController

      before_action do
        authorize! :manage, M3::Profile
      end
      before_action :set_m3_profile, only: [:show, :destroy]
      with_themed_layout 'dashboard'

      #GET /m3_profiles
      def index
        add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb t(:'hyrax.admin.sidebar.m3_profiles'), hyrax.my_m3_profiles_path
        @m3_profiles = M3::Profile.all
        super
      end

      # GET /m3_profiles/1
      def show
        add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb 'M3Profiles', hyrax.my_m3_profiles_path
        add_breadcrumb 'Show'
      end

      # GET /m3_profiles/new
      def new
        add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb 'M3Profiles', hyrax.my_m3_profiles_path
        add_breadcrumb 'New'
        @m3_profile = M3::Profile.new
        @m3_profile.classes.build
        @m3_profile.contexts.build
        @m3_profile.properties.build.texts.build
      end

      # GET /m3_profiles/1/edit
      def edit
        add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb 'M3Profiles', hyrax.my_m3_profiles_path
        add_breadcrumb 'Edit'

        @m3_profile = M3Profile.last
      end

      # POST /m3_profiles
      def create
        @m3_profile = M3::Profile.new(m3_profile_params)

        if @m3_profile.save
          redirect_to my_m3_profiles_path, notice: 'M3Profile was successfully created.'
        else
          render :new
        end
      end

      def import
        uploaded_io = params[:file]
        # @m3_profile = M3ProfileImporter.load_profiles(uploaded_io.path)

        #if @m3_profile.save
        #  redirect_to import_my_m3_profile_path, notice: 'M3Profile was successfully created.'
        #else
        #redirect_to my_m3_profiles_path, alert: "#{@m3_profile.errors.messages}"
        #end
      end

      # DELETE /m3_profiles/1
      def destroy
        @m3_profile.destroy
        redirect_to my_m3_profiles_url, notice: 'M3Profile was successfully destroyed.'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_m3_profile
        @m3_profile = M3::Profile.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def m3_profile_params
        params.require(:m3_profile).permit(:name, :profile_type, :profile_version, :responsibility, :responsibility_statement, :created_at, :updated_at,
                                          :classes_attributes => [:display_label], 
                                          :contexts_attributes => [:display_label],
                                          :properties_attributes => [:name, :property_uri, :cardinality_minimum, :cardinality_maximum, :indexing,
                                                                     :texts_attributes => [:name, :value]])
      end
    end
  end
end
