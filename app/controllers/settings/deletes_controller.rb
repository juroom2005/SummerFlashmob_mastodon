# frozen_string_literal: true

class Settings::DeletesController < Settings::BaseController
  skip_before_action :require_functional!

  before_action :require_not_suspended!
  # flashmob custom: 유저 셀프 계정 삭제 차단. show/destroy 양쪽 진입을 막아 URL 직접 입력·요청 조작 방어.
  # 삭제는 관리자가 tootctl로 처리. 되돌리려면 아래 before_action 한 줄과 block_self_deletion! 메서드만 제거.
  before_action :block_self_deletion!

  def show
    @confirmation = Form::DeleteConfirmation.new
  end

  def destroy
    if challenge_passed?
      destroy_account!
      redirect_to new_user_session_path, notice: I18n.t('deletes.success_msg')
    else
      redirect_to settings_delete_path, alert: I18n.t('deletes.challenge_not_passed')
    end
  end

  private

  def resource_params
    params.expect(form_delete_confirmation: [:password, :username])
  end

  def require_not_suspended!
    forbidden if current_account.unavailable?
  end

  # flashmob custom: 셀프 삭제 차단. show/destroy 진입 시 안내 후 계정 설정 화면으로 되돌림.
  def block_self_deletion!
    redirect_to edit_user_registration_path, alert: I18n.t('deletes.disabled_by_admin')
  end

  def challenge_passed?
    if current_user.encrypted_password.blank?
      current_account.username == resource_params[:username]
    else
      current_user.valid_password?(resource_params[:password])
    end
  end

  def destroy_account!
    current_account.suspend!(origin: :local, block_email: false)
    AccountDeletionWorker.perform_async(current_user.account_id)
    sign_out
  end
end
