#!/bin/bash

# ================================================
# Complicated Build Script (build.sh)
# Estimated runtime: ~10 minutes
# ================================================

set -e  # exit on error
set -o pipefail

LOG_FILE="build.log"
> "$LOG_FILE" # reset log

echo "🚀 Starting build process (~10 mins)..." | tee -a "$LOG_FILE"
START_TIME=$(date +%s)

# ------------------------------------------------
# Step 1: Environment Setup
# ------------------------------------------------
echo "🔧 Setting up environment..." | tee -a "$LOG_FILE"
mkdir -p build output tmp

# ------------------------------------------------
# Step 2: Dummy Dependency Installation Simulation
# ------------------------------------------------
echo "📦 Installing fake dependencies..." | tee -a "$LOG_FILE"
for i in {1..5}; do
  (
    dd if=/dev/zero of=tmp/dep_$i bs=1M count=10 status=none
    sha256sum tmp/dep_$i >> "$LOG_FILE"
    echo "   → Dependency $i installed" >> "$LOG_FILE"
  ) &
done
wait

# ------------------------------------------------
# Step 3: Heavy Computation Simulation
# ------------------------------------------------
echo "⚙️ Running CPU computations..." | tee -a "$LOG_FILE"
for i in {1..4}; do
  (
    python3 - << 'EOF'
import hashlib
for j in range(150000):
    data = f"compute-{j}".encode()
    hashlib.sha256(data).hexdigest()
EOF
    echo "   → Computation thread $i done" >> "$LOG_FILE"
  ) &
done
wait

# ------------------------------------------------
# Step 4: Fake Compilation Steps
# ------------------------------------------------
echo "🛠️ Compiling project modules..." | tee -a "$LOG_FILE"
for module in core api ui cli; do
  (
    for round in {1..30}; do
      echo "   [$module] Build pass $round..." >> "$LOG_FILE"
      echo "int main(){return $round;}" > build/${module}_$round.c
      gcc -O2 -o build/${module}_$round build/${module}_$round.c
      ./build/${module}_$round || true
    done
    echo "   → Module $module built" >> "$LOG_FILE"
  ) &
done
wait

# ------------------------------------------------
# Step 5: Compression & Packaging Simulation
# ------------------------------------------------
echo "📦 Creating fake build artifacts..." | tee -a "$LOG_FILE"
for i in {1..2}; do
  (
    tar -czf output/artifact_$i.tar.gz tmp/ > /dev/null 2>&1
    echo "   → Artifact $i created" >> "$LOG_FILE"
  ) &
done
wait

# ------------------------------------------------
# Step 6: Fake Testing Phase
# ------------------------------------------------
echo "🧪 Running test suite..." | tee -a "$LOG_FILE"
for suite in unit integration e2e; do
  (
    for test in {1..40}; do
      echo "   [$suite] Test $test passed" >> "$LOG_FILE"
      echo "test-$suite-$test" | sha256sum >> /dev/null
    done
    echo "   → $suite tests completed" >> "$LOG_FILE"
  ) &
done
wait

# ------------------------------------------------
# Done
# ------------------------------------------------
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
echo "✅ Build completed in $((ELAPSED / 60)) minutes and $((ELAPSED % 60)) seconds." | tee -a "$LOG_FILE"
