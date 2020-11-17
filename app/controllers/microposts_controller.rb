class MicropostsController < ApplicationController
    before_action :logged_in_user , only: [:create, :destroy]
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end

    def destroy
        # @micropost = Micropost.find(params[:id])
        # if @micropost.destroy
        #     flash[:success] = 'Object was successfully deleted.'
        #     redirect_to microposts_url
        # else
        #     flash[:error] = 'Something went wrong'
        #     redirect_to microposts_url
        # end
    end
    private
        def micropost_params
            params.require(:micropost).permit(:content)
        end
end
