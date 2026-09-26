# skills

Personal [Claude Code skills](https://code.claude.com/docs/en/skills).

| Skill | What it does |
|---|---|
| [direct-img](direct-img/SKILL.md) | How [direct-img.link](https://direct-img.link) image URLs work, including free (public domain / CC0) images |

## Install

Clone the repo anywhere, then copy the skill folders you want into `~/.claude/skills/`:

```bash
git clone https://github.com/multipleof4/skills
```

```bash
mkdir -p ~/.claude/skills && cp -r skills/direct-img ~/.claude/skills/
```

To update, `git pull` and copy again. Claude Code picks up changes to `~/.claude/skills` without a restart.
