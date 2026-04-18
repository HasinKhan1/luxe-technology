#!/bin/bash

# ============================================================
#  LUXE TECHNOLOGY — GitHub Upload Script
#  Works on Mac and Linux
#  Run once, and your site is live on GitHub Pages.
# ============================================================

# ── STEP 1: SET YOUR DETAILS HERE ──────────────────────────
GITHUB_USERNAME="HasinKhan1"   # ← change this
REPO_NAME="luxe-technology"
YOUR_EMAIL="hk@hasinkhan.com"             # ← change this
# ───────────────────────────────────────────────────────────

# Colours for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Colour

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Luxe Technology — GitHub Upload${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ── Check the username was changed ──
if [ "$GITHUB_USERNAME" = "your-github-username" ]; then
  echo -e "${RED}✗  You haven't set your GitHub username yet.${NC}"
  echo ""
  echo "   Open this file in any text editor and change:"
  echo "   GITHUB_USERNAME=\"your-github-username\""
  echo "   to your actual GitHub username, then run again."
  echo ""
  exit 1
fi

# ── Check Git is installed ──
if ! command -v git &> /dev/null; then
  echo -e "${RED}✗  Git is not installed.${NC}"
  echo ""
  echo "   Install it from: https://git-scm.com/downloads"
  echo "   Then run this script again."
  echo ""
  exit 1
fi

echo -e "${GREEN}✓  Git found${NC}"

# ── Check the HTML file is here ──
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HTML_FILE="$SCRIPT_DIR/luxe-technology.html"

if [ ! -f "$HTML_FILE" ]; then
  echo -e "${RED}✗  luxe-technology.html not found.${NC}"
  echo ""
  echo "   Make sure this script is in the same folder as luxe-technology.html"
  echo "   Current folder: $SCRIPT_DIR"
  echo ""
  exit 1
fi

echo -e "${GREEN}✓  luxe-technology.html found${NC}"
echo ""

# ── Set Git identity ──
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$YOUR_EMAIL"

# ── Initialise repo ──
echo -e "${YELLOW}→  Setting up Git repository...${NC}"
cd "$SCRIPT_DIR"

if [ -d ".git" ]; then
  echo "   (Git repo already exists — continuing)"
else
  git init
  git branch -M main
fi

# ── Create index.html so GitHub Pages serves it at root ──
if [ ! -f "index.html" ]; then
  cp luxe-technology.html index.html
  echo -e "${GREEN}✓  Created index.html (GitHub Pages entry point)${NC}"
fi

# ── Create a simple README ──
cat > README.md << EOF
# Luxe Technology

Smart home installation company website — London.

Built with pure HTML and CSS. No frameworks, no dependencies.

## Live site

https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/

## Pages

- Homepage
- Smart home control
- Smart lighting (Lutron certified)
- Multiroom audio
- Home cinema
- Secure networking
- About
- Contact
EOF

echo -e "${GREEN}✓  README.md created${NC}"

# ── Stage and commit ──
echo ""
echo -e "${YELLOW}→  Committing files...${NC}"
git add .
git commit -m "Luxe Technology website — initial launch"
echo -e "${GREEN}✓  Committed${NC}"

# ── Add remote (remove old one if it exists) ──
echo ""
echo -e "${YELLOW}→  Connecting to GitHub...${NC}"
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
echo -e "${GREEN}✓  Remote set to github.com/${GITHUB_USERNAME}/${REPO_NAME}${NC}"

# ── Push ──
echo ""
echo -e "${YELLOW}→  Pushing to GitHub...${NC}"
echo ""
echo -e "${BLUE}   GitHub will now ask for your username and password.${NC}"
echo -e "${BLUE}   Password = your Personal Access Token (not your login password).${NC}"
echo -e "${BLUE}   Get one at: github.com → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token${NC}"
echo -e "${BLUE}   Tick 'repo' scope, generate, copy the token, paste it here.${NC}"
echo ""

git push -u origin main

if [ $? -eq 0 ]; then
  echo ""
  echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}  ✓  Upload complete!${NC}"
  echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo "  Repository: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
  echo ""
  echo -e "${YELLOW}  Now enable GitHub Pages to get a live URL:${NC}"
  echo ""
  echo "  1. Go to: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
  echo "  2. Under 'Source' select: Deploy from branch"
  echo "  3. Branch: main  |  Folder: / (root)"
  echo "  4. Click Save"
  echo ""
  echo "  Your live site will be ready in ~60 seconds at:"
  echo -e "${GREEN}  https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/${NC}"
  echo ""
else
  echo ""
  echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${RED}  ✗  Push failed${NC}"
  echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo "  Most likely causes:"
  echo ""
  echo "  1. The repository doesn't exist yet on GitHub."
  echo "     → Go to github.com/new and create '${REPO_NAME}' first."
  echo "     → Make sure it's EMPTY (no README, no licence)."
  echo ""
  echo "  2. Wrong Personal Access Token."
  echo "     → github.com → Settings → Developer settings"
  echo "     → Personal access tokens → Tokens (classic)"
  echo "     → Generate new token → tick 'repo' → copy token"
  echo ""
  echo "  3. Wrong username."
  echo "     → Check GITHUB_USERNAME at the top of this script."
  echo ""
fi
