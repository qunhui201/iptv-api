#!/bin/bash

ACCEL="https://kenyu.ggff.net/"

FILES=(
  "output/result.m3u"
  "output/ipv4/result.m3u"
  "output/ipv6/result.m3u"
)

echo "🚀 开始加速 EPG: $(date)"

for f in "${FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "⚠️ 文件不存在，跳过: $f"
    continue
  fi

  first_line=$(head -n 1 "$f")

  if [[ "$first_line" == "#EXTM3U x-tvg-url=\"https://raw.githubusercontent.com"* ]]; then
    new_line="#EXTM3U x-tvg-url=\"$ACCEL${first_line#\#EXTM3U x-tvg-url=\"}\""
    sed -i "1s|.*|$new_line|" "$f"
    echo "✅ 已加速: $f"
  else
    echo "ℹ️ 已加速或格式不匹配，跳过: $f"
  fi
done

echo "🎉 完成: $(date)"

exit 0
