---
name: direct-img
description: Find, preview and embed images with direct-img.link, where a URL like https://direct-img.link/orange+cat returns an image directly. Use when the user asks for images, pictures, photos, gifs, reaction images or illustrations, wants images embedded in markdown, HTML, READMEs, docs, slides, emails or web pages, or needs free-to-use (public domain / CC0) images for publishing via free.direct-img.link.
allowed-tools: Bash(bash ${CLAUDE_SKILL_DIR}/scripts/preview.sh *) Read
---

# direct-img.link

A URL is the search: `https://direct-img.link/<query>` searches the web and returns the image itself, so it can be embedded anywhere an image URL works. Results are cached for 90 days, so the same URL keeps showing the same image.

## URL format

- Join words with `+`: `https://direct-img.link/golden+retriever+puppy`
- Percent-encode `.` as `%2E` and `/` as `%2F` (literal ones are rejected), and other special characters as usual (`'` → `%27`, `&` → `%26`). Max 200 characters. Case and extra spaces don't matter.
- `?i=N` (1–20, default 1) serves the N-th working image. Broken links are skipped, so every `i` is a different image.
- `https://free.direct-img.link/<query>` serves only images marked free of restrictions (public domain / CC0), so no credit is needed. It searches Openverse, then Wikimedia Commons. Add `&src=openverse` or `&src=wikimedia` to pick one. Params work in any order.
- A generic "bad" image means no working result (or invalid params); a "limit" image means the daily search limit was hit.

## Which host

- **free.direct-img.link**: anything published or shared where rights matter: websites, articles, blogs, READMEs, repos, docs, newsletters, commercial use.
- **direct-img.link**: chat answers, personal notes, reaction gifs, "show me what X looks like". Much better coverage (current events, people, products, gifs), but images belong to their owners, so don't use it for publishing.
- If free has nothing good, say so instead of quietly switching to the main host for publishable content.

## Picking the best image

When the image matters (the user asked for images, or it will be published), don't blindly embed `i=1`:

1. **Write a specific query**: concrete nouns and details ("golden retriever puppy in snow", not "dog"). On free, drop filler words like "hd", "photo", "image", "high quality" (they must match image text and cause misses). Add "gif" for animated images on the main host.
2. **Preview candidates**:
   ```bash
   bash ${CLAUDE_SKILL_DIR}/scripts/preview.sh [--free] [--src openverse|wikimedia] [--from N] [--to N] "query"
   ```
   It downloads `i=1..3` by default, flags duplicates and the bad/limit images, and prints each file's path. Open every file with the Read tool to see it.
3. **Judge each against the request**: right subject, fits the requested style or mood, no watermarks, text overlays or collages, sharp enough, suitable content, and an orientation that fits where it goes.
4. **If none fit**, rephrase the query (or switch `--src` on free) rather than digging deep into `i`.
5. **Embed the exact URL** of the winner, including `?i=` / `&src=`, e.g. `https://free.direct-img.link/orange+cat?i=2`.

For quick casual images (a reaction gif in chat), skip previewing and embed a well-chosen query directly. If an image can't be displayed by Read, don't guess its content; judge the others.

## Budget

- Every new query + `i` + `src` combination uses 1 of the user's **20 new searches per day** (per IP, shared by both hosts). Cached URLs are free. Previewing costs the same as embedding would, and warms the cache so the embed loads instantly.
- Default to 3 candidates and about 10 new searches per request at most, unless the user asks for more.
- On the limit image, stop and tell the user (it resets at 00:00 UTC).
- Requests are also limited to about 10 per 10 seconds; the script paces itself.

## Embedding

- Always write descriptive alt text: markdown `![golden retriever puppy in snow](url)`, HTML `<img src="url" alt="..." loading="lazy">`.
- Links stay stable for about 90 days. After that, the next request searches again and may return a different image. For permanent content (a site or article that lives for years), suggest downloading the chosen image and hosting it.
- Free-image licenses come from Openverse/Wikimedia metadata and can occasionally be wrong. For important publishing, suggest verifying on the source.
