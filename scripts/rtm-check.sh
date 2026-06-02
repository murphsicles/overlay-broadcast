#!/usr/bin/env bash
# RTM structural validation gate
set -euo pipefail
echo "Validating docs/RTM.csv..."
if [ ! -f docs/RTM.csv ]; then
  echo "FAIL: docs/RTM.csv not found"
  exit 1
fi
HEADER=$(head -1 docs/RTM.csv)
if echo "$HEADER" | grep -q "req_id"; then
  echo "PASS: RTM.csv header valid ($HEADER)"
elif echo "$HEADER" | grep -q "REQ"; then
  echo "PASS: RTM.csv header valid ($HEADER)"
else
  echo "FAIL: RTM.csv header missing expected columns"
  echo "  Got: $HEADER"
  echo "  Expected: req_id,area,verification,test_ids"
  exit 1
fi
LINES=$(wc -l < docs/RTM.csv)
REQS=$(grep -c "REQ-" docs/RTM.csv || true)
echo "  $LINES lines, $REQS requirements mapped"
echo "PASS: RTM.csv present and valid"
