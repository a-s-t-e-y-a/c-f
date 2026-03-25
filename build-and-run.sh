#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Hospital Tourism - Build & Run with PM2${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Check if PM2 is installed
if ! command -v pm2 &> /dev/null; then
    echo -e "${RED}PM2 is not installed. Installing globally...${NC}"
    npm install -g pm2
fi

# Check if serve is installed
if ! command -v serve &> /dev/null; then
    echo -e "${RED}serve package is not installed. Installing locally...${NC}"
    pnpm install serve
fi

# Step 1: Build the project
echo -e "${BLUE}Step 1: Building the project...${NC}"
pnpm run build

if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}Build completed successfully!${NC}\n"

# Step 2: Stop any existing PM2 process
echo -e "${BLUE}Step 2: Checking for existing processes...${NC}"
pm2 delete hospital-tourism 2>/dev/null
echo -e "${GREEN}Ready to start new instance${NC}\n"

# Step 3: Start with PM2
echo -e "${BLUE}Step 3: Starting application with PM2...${NC}"
pm2 start ecosystem.config.cjs

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Application is running on port 3000${NC}"
echo -e "${GREEN}========================================${NC}\n"

# Show PM2 status
echo -e "${BLUE}PM2 Status:${NC}"
pm2 status

echo -e "\n${BLUE}Useful commands:${NC}"
echo "  View logs:          pm2 logs hospital-tourism"
echo "  Stop:               pm2 stop hospital-tourism"
echo "  Restart:            pm2 restart hospital-tourism"
echo "  Delete:             pm2 delete hospital-tourism"
echo "  Monitor:            pm2 monit"
