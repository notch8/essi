module Hyrax
  module My
    class M3ProfilesController < Hyrax::MyController
      include Hyrax::ThemedLayoutController
      require 'yaml'

      before_action do
        authorize! :manage, M3::Profile
      end
      before_action :set_m3_profile, only: [:show, :destroy]
      before_action :set_default_schema, only: [:new, :edit]
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
        if M3::Profile.any?
          redirect_to my_m3_profiles_path, alert: 'Edit an Existing Profile or Upload a New One'
        end

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

        @m3_profile = M3::Profile.last
      end

      # POST /m3_profiles
      def create
        @m3_profile = M3::Profile.new(profile: m3_profile_params[:data])
        M3::FlexibleMetadataConstructor.create_dynamic_schemas(profile: @m3_profile)
        if @m3_profile.save
          redirect_to my_m3_profiles_path, notice: 'M3Profile was successfully created.'
        else
          render :new
        end
      end

      def import
        uploaded_io = params[:file]
        @m3_profile = M3::Importer.load_profile_from_path(path: uploaded_io.path)

        if @m3_profile.save
          redirect_to my_m3_profiles_path, notice: 'M3Profile was successfully created.'
        else
          redirect_to my_m3_profiles_path, alert: "#{@m3_profile.errors.messages}"
        end
      end

      def export
        @m3_profile = M3::Profile.find(params[:m3_profile_id])
        filename = "#{@m3_profile.name}-v.#{@m3_profile.success}.yml"
        File.open(filename, "w") { |file| file.write(@m3_profile.profile.to_yaml) }
        send_file filename, :type=>"application/yaml", :x_sendfile=>true
      end

      # DELETE /m3_profiles/1
      def destroy
        @m3_profile.destroy
        message = 'M3Profile was successfully destroyed.'
        message = @m3_profile.errors[:base] if @m3_profile.errors[:base]
        redirect_to my_m3_profiles_url, alert: message
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_m3_profile
        @m3_profile = M3::Profile.find(params[:id])
      end

      def set_default_schema
        #use default json schema
        new_json_schema = File.open "config/metadata_profiles/default_schema.json"
        @default_schema = JSON.load new_json_schema
        new_json_schema.close
      end

      # Only allow a trusted parameter "white list" through.
      def m3_profile_params
        params.require(:m3_profile).permit!
      end
    end
  end
end
