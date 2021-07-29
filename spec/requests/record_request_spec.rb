require 'rails_helper'

RSpec.describe "Records", type: :request do
    describe "#new" do
        let!(:record) { create(:record) }
        let!(:user) { record.user }

        context "ユーザがログイン済みの時" do
            it "正常にレスポンスを返す" do
                sign_in user
                get new_record_path
                aggregate_failures do
                    expect(response).to be_successful
                    expect(response).to have_http_status "200"
                end
            end
        end

        context "ユーザーがログインしていない時" do
            it "302レスポンスを返す" do
                get new_record_path
                aggregate_failures do
                    expect(response).to have_http_status "302"
                    expect(response).to redirect_to login_path
                end
            end
        end
    end

    describe "#create" do
        let!(:user) { create(:user) }
        let(:record_params) { attributes_for(:record) }

        context "ユーザーがログイン済みの時" do
            it "学習記録の追加ができる" do
                sign_in user
                post records_path, params: { record: record_params }
                aggregate_failures do
                    expect(user.records.count).to eq 1
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end

        context "ユーザーがログインしていないの時" do
            it "学習記録の追加ができない" do
                post records_path, params: { record: record_params }
                aggregate_failures do
                    expect(user.records.count).not_to eq 1
                    expect(response).to redirect_to login_path
                end
            end
        end

        context "無効な属性値の時" do
            it "新規作成ページに戻る" do
                record_params[:hour] = 1.3
                post records_path, params: { record: record_params }
                aggregate_failures do
                    expect(user.records.count).not_to eq 1
                    expect(response).to redirect_to login_path
                end
            end
        end
    end

    describe "#edit" do
        let!(:record) { create(:record) }
        let!(:user) { record.user }

        context "ユーザーがログイン済みの時" do
            it "正常にレスポンスを返す" do
                sign_in user
                get edit_record_path(record)
                aggregate_failures do
                    expect(response).to have_http_status "200"
                    expect(response).to be_successful
                end
            end
        end

        context "ユーザーがログインしていないの時" do
            it "ログインページに戻る" do
                get edit_record_path(record)
                aggregate_failures do
                    expect(response).to have_http_status "302"
                    expect(response).to redirect_to login_path
                end
            end
        end

        context "管理者権限のあるユーザーが編集しようとした時" do
            it "正常にレスポンスを返す" do
                other_user = create(:user, admin: true)
                sign_in other_user
                get edit_record_path(record)
                aggregate_failures do
                    expect(response).to have_http_status "200"
                    expect(response).to be_successful
                end
            end
        end

        context "管理者権限のないユーザーが編集しようとした時" do
            it "ユーザーページに戻る" do
                other_user = create(:user)
                sign_in other_user
                get edit_record_path(record)
                aggregate_failures do
                    expect(response).to have_http_status "302"
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end
    end

    describe "#update" do
        let!(:record_params) { attributes_for(:record, date: "2021-04-11", hour: 2, minute: 2) }
        let!(:record) { create(:record) }
        let!(:user) { record.user }

        context "ユーザーがログイン済みの時" do
            it "自分の記録を編集できる" do
                sign_in user
                patch record_path(record.id), params: { record: record_params }
                aggregate_failures do
                    expect(record.reload.date.to_s).to eq "2021-04-11"
                    expect(record.reload.hour).to eq 2
                    expect(record.reload.minute).to eq 2
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end

        context "ユーザーがログインしていない時" do
            it "ログインページに戻る" do
                patch record_path(record.id), params: { record: record_params }
                aggregate_failures do
                    expect(record.reload.date.to_s).not_to eq "2021-04-11"
                    expect(record.reload.hour).not_to eq 2
                    expect(record.reload.minute).not_to eq 2
                    expect(response).to redirect_to login_path
                end
            end
        end

        context "管理者権限のあるユーザーの時" do
            it "他のユーザーの学習記録を編集できる" do
                other_user = create(:user, admin: true)
                sign_in other_user
                patch record_path(record.id), params: { record: record_params }
                aggregate_failures do
                    expect(record.reload.date.to_s).to eq "2021-04-11"
                    expect(record.reload.hour).to eq 2
                    expect(record.reload.minute).to eq 2
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end

        context "管理者権限のないユーザーが編集しようとした時" do
            it "編集しようとした学習記録のユーザーページに戻る" do
                other_user = create(:user)
                sign_in other_user
                patch record_path(record.id), params: { record: record_params }
                aggregate_failures do
                    expect(record.reload.date.to_s).not_to eq "2021-04-11"
                    expect(record.reload.hour).not_to eq 2
                    expect(record.reload.minute).not_to eq 2
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end
    end

    describe "#destroy" do
        let!(:record) { create(:record) }
        let!(:user) { record.user }

        context "ユーザーがログイン済みの時" do
            it "自分の記録を削除できる" do
                sign_in user
                delete record_path(record.id)
                aggregate_failures do
                    expect(user.records.count).to eq 0
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end

        context "ユーザーがログインしていない時" do
            it "ログインページに戻る" do
               delete record_path(record.id)
                aggregate_failures do
                    expect(user.records.count).to eq 1
                    expect(response).to redirect_to login_path
                end
            end
        end

        context "管理者権限のあるユーザーの時" do
            it "他のユーザーの学習記録を削除できる" do
                other_user = create(:user, admin: true)
                sign_in other_user
                delete record_path(record.id)
                aggregate_failures do
                    expect(user.records.count).to eq 0
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end

        context "管理者権限のないユーザーが編集しようとした時" do
            it "編集しようとした学習記録のユーザーページに戻る" do
                other_user = create(:user)
                sign_in other_user
                delete record_path(record.id)
                aggregate_failures do
                    expect(user.records.count).to eq 1
                    expect(response).to redirect_to record_show_user_path(user)
                end
            end
        end
    end
end
