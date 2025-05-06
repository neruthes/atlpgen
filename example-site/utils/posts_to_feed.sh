#!/bin/bash

# Usage: ./generate_rss.sh /path/to/directory

set -e

DIR="$1"
if [[ -z "$DIR" || ! -d "$DIR" ]]; then
  echo "Usage: $0 /path/to/directory"
  exit 1
fi

OUTPUT_FILE="$DIR/main.xml"

# Begin RSS feed
cat <<EOF > "$OUTPUT_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
  <title>Plaintext Feed</title>
  <link>http://example.com/</link>
  <description>RSS feed of plaintext files</description>
EOF

# Find and sort files by timestamp
find "$DIR" -maxdepth 5 -name '*.txt' -type f | while read -r FILE; do
  BASENAME="$(basename "$FILE")"
  TIMESTAMP="$(echo "$BASENAME" | cut -d- -f1)"
  if ! [[ "$TIMESTAMP" =~ ^[0-9]+$ ]]; then
    continue
  fi
  DATE_RFC822="$(date -d @"$TIMESTAMP" -R 2>/dev/null || date -r "$TIMESTAMP" -R)"
  TITLE="${BASENAME%.txt}"
  DESCRIPTION="$(sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' "$FILE")"
  LINK="http://example.com/$BASENAME"

  cat <<ITEM >> "$OUTPUT_FILE"
  <item>
    <title>$TITLE</title>
    <link>$LINK</link>
    <guid isPermaLink="false">$LINK</guid>
    <pubDate>$DATE_RFC822</pubDate>
    <description><![CDATA[
$DESCRIPTION
    ]]></description>
  </item>
ITEM
done

# Close RSS feed
cat <<EOF >> "$OUTPUT_FILE"
</channel>
</rss>
EOF

echo "RSS feed generated at $OUTPUT_FILE"
