PROJECT="$1"
SCHEME="$2"
DESTINATION="$3"

echo $SCHEME
echo $DESTINATION
echo $PROJECT

run: |
    arch -arm64 xcodebuild clean test \
    -project $PROJECT \
    -scheme $SCHEME \
    -destination $DESTINATION \
    -resultBundlePath "Build/Result/${GITHUB_RUN_ID}-iOS15-Simulator.xcresult" \
    -derivedDataPath Build/DerivedData | xcpretty && exit ${PIPESTATUS[0]}