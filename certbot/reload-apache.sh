#!/usr/bin/env bash
# ==============================================================================
# Certbot Deploy Hook: Apache2 リロード & Discord 通知
#
# 配置先: /etc/letsencrypt/renewal-hooks/deploy/reload-apache.sh
# 
# 動作:
#   1. openssl でリロード前の localhost:443 の証明書期限（notAfter）を取得
#   2. 事前通知（リロード前期限を含む）
#   3. systemctl reload apache2 を実行
#   4. openssl でリロード後の localhost:443 の証明書期限（notAfter）を取得
#   5. 結果通知（リロード後期限を含む）
# ==============================================================================
set -u

# 呼び出し先スクリプトのフルパス
NOTIFY_SCRIPT="/home/swirhen/sh/notify_certbot_discord.sh"

# Discord の投稿先ターゲット（swirhen/discord_webhook_url の第1カラム名）
export DISCORD_TARGET="bot-open"

# openssl で localhost:443 の証明書有効期限を取得する関数
get_cert_expiry() {
    # SNI (Server Name Indication) が必要な場合は RENEWED_DOMAINS の第1ドメインを使用
    local server_name="${RENEWED_DOMAINS%% *}"
    local sni_opt=""
    if [[ -n "${server_name}" ]]; then
        sni_opt="-servername ${server_name}"
    fi

    # openssl s_client で localhost:443 に接続して notAfter を取得
    local expiry
    expiry=$(echo | openssl s_client -connect 127.0.0.1:443 ${sni_opt} 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | sed 's/^notAfter=//')
    
    if [[ -n "${expiry}" ]]; then
        echo "${expiry}"
    else
        echo "取得失敗"
    fi
}

# Discord 通知呼び出しヘルパー関数
send_notification() {
    local status="$1"
    local message="$2"
    local expiry="${3:-}"
    if [[ -x "${NOTIFY_SCRIPT}" ]]; then
        "${NOTIFY_SCRIPT}" "${status}" "${message}" "${expiry}" || echo "[WARN] Discord 通知に失敗しました。" >&2
    elif [[ -f "${NOTIFY_SCRIPT}" ]]; then
        bash "${NOTIFY_SCRIPT}" "${status}" "${message}" "${expiry}" || echo "[WARN] Discord 通知に失敗しました。" >&2
    else
        echo "[WARN] 通知スクリプトが見つかりません: ${NOTIFY_SCRIPT}" >&2
    fi
}

# 1. リロード前の証明書期限を取得
PRE_EXPIRY=$(get_cert_expiry)

# 2. リロード前の事前通知
send_notification "開始" "証明書更新が行われました。apache2をリロードします。" "${PRE_EXPIRY}"

# 3. Apache2 のリロード実行
if systemctl reload apache2; then
    STATUS="成功"
    MSG="apache2を正常にリロードしました。"
    EXIT_CODE=0
else
    STATUS="失敗"
    MSG="⚠️ apache2のリロードに失敗しました！ログを確認してください。"
    EXIT_CODE=1
fi

# 4. リロード後の証明書期限を取得（リロード反映を確実に拾うため1秒ウェイト）
sleep 1
POST_EXPIRY=$(get_cert_expiry)

# 5. リロード後の結果通知
send_notification "${STATUS}" "${MSG}" "${POST_EXPIRY}"

exit ${EXIT_CODE}
