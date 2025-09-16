#!/bin/bash

# ================================================
# Complicated Build Script (build.sh)
# Estimated runtime: ~30–40 minutes
# ================================================

set -e  # exit on error
set -o pipefail

LOG_FILE="build.log"
> "$LOG_FILE" # reset log

echo "🚀 Starting build process..." | tee -a "$LOG_FILE"
START_TIME=$(date +%s)

# ------------------------------------------------
# Step 1: Environment Setup
# ------------------------------------------------
echo "🔧 Setting up environment..." | tee -a "$LOG_FILE"
mkdir -p build output tmp
sleep 5

# ------------------------------------------------
# Step 2: Dummy Dependency Installation Simulation
# (simulate fetching, installing, extracting)
# ------------------------------------------------
for i in {1..10}; do
    echo "📦 Installing dependency $i..." | tee -a "$LOG_FILE"
    dd if=/dev/zero of=tmp/dep_$i bs=1M count=50 status=none
    sleep 20
done

# ------------------------------------------------
# Step 3: Heavy Computation Simulation
# (hashing big data chunks to eat CPU)
# ------------------------------------------------
echo "⚙️ Running heavy CPU computations..." | tee -a "$LOG_FILE"
for i in {1..5}; do
    dd if=/dev/urandom of=tmp/random_$i bs=10M count=10 status=none
    sha256sum tmp/random_$i >> "$LOG_FILE"
    sleep 15
done

# ------------------------------------------------
# Step 4: Fake Compilation Steps
# ------------------------------------------------
echo "🛠️ Compiling project modules..." | tee -a "$LOG_FILE"
for module in core api ui cli tests docs; do
    echo "🔨 Building module: $module..." | tee -a "$LOG_FILE"
    for round in {1..50}; do
        echo "   Pass $round..." >> "$LOG_FILE"
        sleep 3
    done
done

# ------------------------------------------------
# Step 5: Compression & Packaging Simulation
# ------------------------------------------------
echo "📦 Creating fake build artifacts..." | tee -a "$LOG_FILE"
for i in {1..3}; do
    tar -czf output/artifact_$i.tar.gz tmp/ > /dev/null 2>&1
    echo "   → Artifact $i created" | tee -a "$LOG_FILE"
    sleep 30
done

# ------------------------------------------------
# Step 6: Fake Testing Phase
# ------------------------------------------------
echo "🧪 Running test suite..." | tee -a "$LOG_FILE"
for suite in unit integration e2e performance stress security; do
    echo "▶️ Executing $suite tests..." | tee -a "$LOG_FILE"
    for test in {1..20}; do
        echo "   Test $test passed" >> "$LOG_FILE"
        sleep 6
    done
done

# ------------------------------------------------
# Step 7: Final Sleep for Guarantee
# ------------------------------------------------
echo "⌛ Finalizing build (cooldown)..." | tee -a "$LOG_FILE"
sleep 300 # extra 5 minutes to ensure runtime

# ------------------------------------------------
# Done
# ------------------------------------------------
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
echo "✅ Build completed in $((ELAPSED / 60)) minutes and $((ELAPSED % 60)) seconds." | tee -a "$LOG_FILE"
