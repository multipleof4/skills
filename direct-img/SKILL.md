---
name: direct-img
description: Embed images anywhere with direct-img.link URLs, where https://direct-img.link/orange+cat returns an image directly. For finding or embedding images, photos, gifs or illustrations in chat, markdown, HTML, docs or web pages, and free.direct-img.link for public domain / CC0 images.
---

# direct-img.link

`https://direct-img.link/<query>` returns an image found by searching for `<query>`. It works anywhere an image URL does.

## URLs

- Words are joined with `+`: `https://direct-img.link/golden+retriever+puppy`
- Literal `.` and `/` are rejected; encode them as `%2E` and `%2F`. Other special characters are percent-encoded as usual. Max 200 characters; case and extra spaces are ignored.
- `?i=N` (1–20, default 1) returns the N-th working image for the query. Each `i` is a different image.
- A URL keeps returning the same image for 90 days, then may return a different one.
- With no result or an invalid parameter, a placeholder [bad image](https://direct-img.link/assets/bad.webp) is returned.
- Any URL can be downloaded and viewed to see what it returns.

## Free images

- `https://free.direct-img.link/<query>` returns only images marked public domain or CC0, from Openverse, then Wikimedia Commons. No credit is needed. It has far fewer images than the main host.
- `?src=openverse` or `?src=wikimedia` limits it to one source. `src` and `i` combine in any order.
