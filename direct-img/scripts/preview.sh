#!/usr/bin/env bash
# Download direct-img.link candidates for a query so they can be viewed and compared.
# Usage: preview.sh [--free] [--src openverse|wikimedia] [--from N] [--to N] [--out DIR] "query"
set -eu

host=direct-img.link src= from=1 to=3 out=
while [ $# -gt 1 ]; do
  case $1 in
    --free) host=free.direct-img.link; shift ;;
    --src) src=$2; host=free.direct-img.link; shift 2 ;;
    --from) from=$2; shift 2 ;;
    --to) to=$2; shift 2 ;;
    --out) out=$2; shift 2 ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done
[ $# -eq 1 ] || { sed -n 3p "$0" >&2; exit 2; }

# Encode via stdin so UTF-8 survives on Windows; direct-img.link rejects literal dots
path=$(printf %s "$1" | curl -Gso /dev/null -w '%{url_effective}' --data-urlencode @- http://x/ | cut -d'?' -f2- | sed 's/\./%2E/g')
out=${out:-$(mktemp -d "${TMPDIR:-/tmp}/direct-img.XXXXXX")}
mkdir -p "$out"
h() { { sha256sum 2>/dev/null || shasum -a 256; } < "$1" | cut -c1-12; }

# The site's own placeholders, to recognize "no result" and "limit reached"
curl -sf https://direct-img.link/assets/bad.webp -o "$out/.bad" && bad=$(h "$out/.bad") || bad=none
curl -sf https://direct-img.link/assets/limit.webp -o "$out/.limit" && limit=$(h "$out/.limit") || limit=none

echo "Saved to $out (open each file with the Read tool)"
seen=
for i in $(seq "$from" "$to"); do
  url="https://$host/$path?i=$i${src:+&src=$src}"
  f="$out/i$i"
  ct=$(curl -s -o "$f" -w '%{content_type}' "$url") || { echo "i=$i request failed: $url"; continue; }
  x=$(h "$f")
  case $x in
    "$limit") rm -f "$f"; echo "i=$i LIMIT: daily search limit reached (resets 00:00 UTC), stopping"; break ;;
    "$bad") rm -f "$f"; echo "i=$i NONE: fewer than $i working images for this query, stopping"; break ;;
  esac
  ext=${ct#image/}; ext=${ext%%;*}
  case $ext in jpeg) ext=jpg ;; svg+xml) ext=svg ;; esac
  mv "$f" "$f.$ext"
  dims=$(file -b "$f.$ext" 2>/dev/null | grep -oE '[0-9]+ ?x ?[0-9]+' | tail -1 | tr -d ' ')
  dup=$(printf '%s\n' $seen | grep "^$x=" | cut -d= -f2)
  seen="$seen $x=$i"
  echo "i=$i $url"
  echo "    $f.$ext  ${dims:-?}  $(wc -c < "$f.$ext" | tr -d ' ')B${dup:+  DUPLICATE of i=$dup}"
  sleep 1
done
