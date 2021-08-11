class Api::UsersController < Api::BaseController
  skip_before_action :ward_by_user!, only: [:sign_in]

  def sign_in
    mp_sign_in
  end

  private

  def mp_sign_in
    resp = Faraday.new('https://api.weixin.qq.com').get(
      '/sns/jscode2session',
      appid: Settings.wechat_mp.app_id,
      secret: Settings.wechat_mp.app_secret,
      js_code: params[:code],
      grant_type: 'authorization_code'
    )
    resp = JSON.parse(resp.body)
    if resp['errcode'] && resp['errcode'] != 0
      Rails.logger.error resp
      render json: {}, status: :bad_request
      return
    end

    openid, session_key = resp['openid'], resp['session_key']
    data = Hashie::Mash.new(params[:user_info])

    wechat_user = nil
    User.transaction do
      wechat_user = WechatUser.where(open_id: openid).first_or_create! do |wechat_user|
        wechat_user.user = User.create!(nickname: data.nickName, avatar: data.avatarUrl)
        wechat_user.nickname = data.nickName
        wechat_user.avatar_url = data.avatarUrl
        wechat_user.gender = data.gender
        wechat_user.language = data.language
        wechat_user.country = data.country
        wechat_user.province = data.province
        wechat_user.city = data.city
        wechat_user.raw_data = data.to_json
      end
    end

    user_id = wechat_user.user_id
    access_token, refresh_token = generate_tokens_for_user(user_id)
    render json: {
      user_id: user_id,
      access_token: access_token,
      refresh_token: refresh_token
    }
  end
end
