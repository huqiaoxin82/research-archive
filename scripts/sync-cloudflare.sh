#!/bin/bash
# =============================================================================
# Cloudflare Pages 同步脚本
# 用于手动触发 Cloudflare Pages 重新部署或验证同步状态
# =============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Cloudflare 配置 (需要用户手动配置)
CF_ACCOUNT_ID="${CF_ACCOUNT_ID:-}"
CF_PROJECT_NAME="${CF_PROJECT_NAME:-research-archive}"
CF_API_TOKEN="${CF_API_TOKEN:-}"

# 帮助信息
show_help() {
    cat << EOF
Cloudflare Pages 同步脚本

用法:
    $0 [命令]

命令:
    status          检查 Cloudflare Pages 部署状态
    deploy          手动触发重新部署
    setup           显示 Cloudflare Pages 设置指南
    help            显示帮助信息

环境变量:
    CF_ACCOUNT_ID   Cloudflare 账户 ID
    CF_API_TOKEN    Cloudflare API Token
    CF_PROJECT_NAME 项目名称 (默认: research-archive)

示例:
    CF_API_TOKEN=xxx $0 status
    $0 deploy
EOF
}

# 检查依赖
check_deps() {
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}错误: 需要安装 curl${NC}"
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        echo -e "${YELLOW}警告: 建议安装 jq 以获得更好的输出格式${NC}"
    fi
}

# 检查配置
check_config() {
    if [ -z "$CF_API_TOKEN" ]; then
        echo -e "${RED}错误: 未设置 CF_API_TOKEN${NC}"
        echo "请设置环境变量: export CF_API_TOKEN=your_token"
        exit 1
    fi
    
    if [ -z "$CF_ACCOUNT_ID" ]; then
        echo -e "${RED}错误: 未设置 CF_ACCOUNT_ID${NC}"
        echo "请设置环境变量: export CF_ACCOUNT_ID=your_account_id"
        exit 1
    fi
}

# 获取部署状态
get_status() {
    check_config
    
    echo -e "${BLUE}检查 Cloudflare Pages 部署状态...${NC}"
    
    RESPONSE=$(curl -s -X GET \
        "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/pages/projects/${CF_PROJECT_NAME}/deployments" \
        -H "Authorization: Bearer ${CF_API_TOKEN}" \
        -H "Content-Type: application/json")
    
    if command -v jq &> /dev/null; then
        echo "$RESPONSE" | jq '.result[0] | {id, url, environment, latest_stage, created_on}'
    else
        echo "$RESPONSE"
    fi
}

# 触发部署
trigger_deploy() {
    check_config
    
    echo -e "${BLUE}触发 Cloudflare Pages 重新部署...${NC}"
    
    # 注意: 由于 Cloudflare Pages 与 GitHub 集成，
    # 通常 Git push 会自动触发部署
    # 这里提供手动触发的方式
    
    echo -e "${YELLOW}提示: Cloudflare Pages 已与 GitHub 集成${NC}"
    echo -e "${YELLOW}推送代码到 GitHub 会自动触发 Cloudflare 部署${NC}"
    
    # 创建空提交触发部署
    git commit --allow-empty -m "触发 Cloudflare Pages 重新部署 [ci skip]"
    git push origin main
    
    echo -e "${GREEN}✓ 已推送空提交，Cloudflare Pages 将自动部署${NC}"
}

# 设置指南
show_setup() {
    cat << EOF
${BLUE}=== Cloudflare Pages 设置指南 ===${NC}

1. 登录 Cloudflare Dashboard
   https://dash.cloudflare.com

2. 创建 Pages 项目
   - 点击 "Workers & Pages"
   - 选择 "Create a project"
   - 选择 "Connect to Git"

3. 连接 GitHub 仓库
   - 选择 huqiaoxin82/research-archive
   - 授权 Cloudflare 访问

4. 配置构建设置
   - Framework preset: None
   - Build command: (留空，使用 GitHub Pages)
   - Build output directory: docs

5. 设置自定义域名 (可选)
   - 添加你的域名
   - 配置 DNS 记录

6. 获取 API Token (用于脚本)
   - 访问 https://dash.cloudflare.com/profile/api-tokens
   - 创建 Token，包含 Zone:Read 和 Page Rules:Edit 权限
   - 设置环境变量:
     export CF_API_TOKEN=your_token
     export CF_ACCOUNT_ID=your_account_id

预期访问地址:
   https://${CF_PROJECT_NAME}.pages.dev
   或你的自定义域名

EOF
}

# 主逻辑
case "${1:-help}" in
    status)
        check_deps
        get_status
        ;;
    deploy)
        check_deps
        trigger_deploy
        ;;
    setup)
        show_setup
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}错误: 未知命令 $1${NC}"
        show_help
        exit 1
        ;;
esac
