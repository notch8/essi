module Hyrax
  module My
    class M3ProfilesController < Hyrax::MyController
      before_action :set_m3_profile, only: [:show, :edit, :update, :destroy]
      before_action do
        authorize! :manage, M3Profile
      end
      include Hyrax::ThemedLayoutController


      #GET /m3_profiles
      def index
        add_breadcrumb t(:'hyrax.controls.home'), root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb t(:'hyrax.admin.sidebar.m3_profiles'), hyrax.my_m3_profiles_path
        @m3_profiles = M3Profile.all
      end

      # GET /m3_profiles/1
      def show
      end

      # GET /m3_profiles/new
      def new
        add_breadcrumb t(:'hyrax.controls.home'), root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb 'M3Profiles', hyrax.my_m3_profiles_path
        @m3_profile = M3Profile.new
      end

      # GET /m3_profiles/1/edit
      def edit
        add_breadcrumb t(:'hyrax.controls.home'), root_path
        add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
        add_breadcrumb 'M3Profiles', hyrax.my_m3_profiles_path
      end

      # POST /m3_profiles
      def create
        @m3_profile = M3Profile.new(m3_profile_params)

        if @m3_profile.save
          redirect_to my_m3_profiles_path, notice: 'M3Profile was successfully created.'
        else
          render :new
        end
      end

      # PATCH/PUT /m3_profiles/1
      def update
        if @m3_profile.update(m3_profile_params)
          redirect_to my_m3_profiles_path, notice: 'M3Profile was successfully updated.'
        else
          render :edit
        end
      end

      # DELETE /m3_profiles/1
      def destroy
        @m3_profile.destroy
        redirect_to my_m3_profiles_url, notice: 'M3Profile was successfully destroyed.'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_m3_profile
        @m3_profile = M3Profile.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def m3_profile_params
        params.require(:m3_profile).permit(:name, :profile_version, :profile, :created_at, :updated_at)
      end
    end
  end
end
