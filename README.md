# skills

Personal [Claude Code skills](https://code.claude.com/docs/en/skills).

| Skill | What it does |
|---|---|
| [direct-img](direct-img/SKILL.md) | How [direct-img.link](https://direct-img.link) image URLs work, including free (public domain / CC0) and AI-generated images |

## Install

Clone the repo anywhere, then copy the skill folders you want into `~/.claude/skills/`:

```bash
git clone https://github.com/multipleof4/skills
```

```bash
mkdir -p ~/.claude/skills && cp -r skills/direct-img ~/.claude/skills/
```

To update, `git pull` and copy again. Claude Code picks up changes to `~/.claude/skills` without a restart.

## Moved

The vibegif skill lives in [its own repo](https://github.com/direct-img/vibegif.direct-img.link/tree/main/skills/vibegif) now. Install it straight from the site:

```bash
mkdir -p ~/.claude/skills/vibegif && curl -fsS https://vibegif.direct-img.link/SKILL.md -o ~/.claude/skills/vibegif/SKILL.md
```
