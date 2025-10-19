#!/bin/bash

FILES=(
  "../output/ipv4/result.m3u"
  "../output/ipv6/result.m3u"
  "../output/result.m3u"
)

for FILE in "${FILES[@]}"; do
  if [[ -f "$FILE" ]]; then
    if grep -q "https://kenyu.ggff.net/" "$FILE"; then
      echo "✅ 已加速，跳过: $FILE"
    else
      echo "🚀 添加加速: $FILE"
      sed -i 's#x-tvg-url="https://#x-tvg-url="https://kenyu.ggff.net/https://#' "$FILE"
    fi
  fi
done
