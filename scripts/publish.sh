#!/bin/bash
# =============================================================================
# 研究报告发布脚本
# 用法: ./publish.sh "报告标题" "分类" ./path/to/report.md
# =============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 帮助信息
show_help() {
    cat << EOF
研究报告发布脚本

用法:
    $0 [选项] "报告标题" "分类" ./path/to/report.md

选项:
    -h, --help      显示帮助信息
    -d, --date      指定日期 (默认: 今天)
    -t, --tags      添加标签 (逗号分隔)

示例:
    $0 "AI技术趋势分析" "2025-03" ./draft.md
    $0 -d 2025-03-15 "新技术报告" "tech" ./report.md
    $0 -t "AI,机器学习" "AI发展趋势" "2025-03" ./ai-report.md
EOF
}

# 参数解析
DATE=$(date +%Y-%m-%d)
TAGS=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--date)
            DATE="$2"
            shift 2
            ;;
        -t|--tags)
            TAGS="$2"
            shift 2
            ;;
        -*)
            echo -e "${RED}错误: 未知选项 $1${NC}"
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# 检查必要参数
if [ $# -lt 3 ]; then
    echo -e "${RED}错误: 参数不足${NC}"
    show_help
    exit 1
fi

TITLE="$1"
CATEGORY="$2"
SOURCE_FILE="$3"

# 检查源文件
if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}错误: 源文件不存在: $SOURCE_FILE${NC}"
    exit 1
fi

# 提取年月
YEAR_MONTH=$(echo "$DATE" | cut -d'-' -f1-2)

# 生成文件名
FILENAME=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
FILENAME="${FILENAME}.md"

# 目标目录
TARGET_DIR="docs/research/${YEAR_MONTH}"
TARGET_FILE="${TARGET_DIR}/${FILENAME}"

echo -e "${YELLOW}发布研究报告...${NC}"
echo "标题: $TITLE"
echo "日期: $DATE"
echo "分类: $CATEGORY"
echo "目标: $TARGET_FILE"

# 创建目录
mkdir -p "$TARGET_DIR"

# 生成文件头
cat > "$TARGET_FILE" << EOF
---
layout: default
title: "$TITLE"
date: $DATE
category: "$CATEGORY"
tags: [$TAGS]
author: "胡巧信"
---

# $TITLE

> 调研日期: $DATE  
> 分类: $CATEGORY

---

EOF

# 追加内容
cat "$SOURCE_FILE" >> "$TARGET_FILE"

echo -e "${GREEN}✓ 文件已创建: $TARGET_FILE${NC}"

# Git 操作
echo -e "${YELLOW}提交到 Git...${NC}"

git add "$TARGET_FILE"
git commit -m "添加研究报告: $TITLE"
git push origin main

echo -e "${GREEN}✓ 已推送到 GitHub${NC}"
echo -e "${GREEN}✓ GitHub Pages 将在几分钟内自动更新${NC}"
