PROJECT="$1"
WORKSPACE="$2"
SCHEME="$3"
DESTINATION="$4"

echo $PROJECT
echo $WORKSPACE
echo $SCHEME
echo $DESTINATION

arch -arm64 xcodebuild clean test \
    -project $PROJECT
    -scheme "$SCHEME" \
    -destination "$DESTINATION" \
    -resultBundlePath "Build/Result/${GITHUB_RUN_ID}-iOS15-Simulator.xcresult" \
    -derivedDataPath Build/DerivedData | xcpretty && exit ${PIPESTATUS[0]}