class MembersController < ApplicationController
    before_action :login_required

    def index
        @members = Member.order("number")
            .page(params[:page]).per(15)
    end

    def show
        @member = Member.find(params[:id])
    end

    def new
        @member = Member.new(birthday: Date.new(1998, 1, 1))
    end

    def edit
        @member = Member.find(params[:id])
    end

    def create
        @member = Member.new(member_params)
        if @member.save
            redirect_to @member, notice: "会員を登録しました"
        else
            render "new"
        end
    end

    def update
        @member = Member.find(params[:id])
        @member.assign_attributes(member_params)
        if @member.save
            redirect_to @member, notice: "会員登録を更新しました。"
        else
            render "new"
        end
    end

    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        if current_member.present?
            redirect_to :members, notice: "会員を削除しました。"
        else
            redirect_to :root
        end
    end

    def search
        @members = Member.search(params[:q])
            .page(params[:page]).per(15)
        render "index"
    end

    private def member_params
        attrs = [
            :new_profile_picture,
            :remove_profile_picture,
            :number,
            :name,
            :full_name,
            :sex,
            :birthday,
            :email,
            :administrator
        ]

        attrs << :password if params[:action] == "create"

        params.require(:member).permit(attrs)
    end
end