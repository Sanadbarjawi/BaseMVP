
UNIVERSAL_OUTPUTFOLDER="output"
BUILD_DIR="build"
WORKSPACE_PATH="BaseMVP.xcodeproj"
TARGET_NAME="BaseMVP"
SIM_SDK_PATH="${BUILD_DIR}/Release-iphonesimulator"
OS_SDK_PATH="${BUILD_DIR}/Release-iphoneos"

# make sure the output directory exists
rm -rf "${UNIVERSAL_OUTPUTFOLDER}"
rm -rf "${BUILD_DIR}"

mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"
mkdir -p "${BUILD_DIR}"
mkdir -p "${SIM_SDK_PATH}"
mkdir -p "${OS_SDK_PATH}"



echo "Building for iPhoneSimulator"
xcodebuild -project "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration "Release" -destination 'platform=iOS Simulator,name=iPhone 8' only_active_arch=no define_modules=yes -sdk iphonesimulator  clean build -showBuildSettings > buildlog
TARGET_DIR=`cat buildlog | grep -m1 TARGET_BUILD_DIR | awk '{ print $3 }'`
xcodebuild -project "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration "Release" -destination 'platform=iOS Simulator,name=iPhone 8' only_active_arch=no define_modules=yes -sdk iphonesimulator SKIP_INSTALL=NO ENABLE_BITCODE=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE=bitcode clean build
mv "${TARGET_DIR}/${TARGET_NAME}.framework" "${SIM_SDK_PATH}/${TARGET_NAME}.framework"
echo "***********"
echo $TARGET_DIR





echo "Building for Device"
rm -rf buildlog
echo "Building for ios"
xcodebuild -project "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration "Release"  only_active_arch=no define_modules=yes -sdk iphoneos  clean build -showBuildSettings > buildlog
TARGET_DIR=`cat buildlog | grep -m1 TARGET_BUILD_DIR | awk '{ print $3 }'`
xcodebuild -project "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration "Release"  only_active_arch=no define_modules=yes -sdk iphoneos SKIP_INSTALL=NO ENABLE_BITCODE=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE=bitcode clean build
mv "${TARGET_DIR}/${TARGET_NAME}.framework" "${OS_SDK_PATH}/${TARGET_NAME}.framework"
echo "***********"
echo $TARGET_DIR



# Step 2. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
SIMULATOR_SWIFT_MODULES_DIR="${SIM_SDK_PATH}/${TARGET_NAME}.framework/Modules/${TARGET_NAME}.swiftmodule"

cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${OS_SDK_PATH}/${TARGET_NAME}.framework/Modules"

# Step 3. Create universal binary file using lipo and place the combined executable in the copied framework directory

cp -R "${OS_SDK_PATH}/" "${UNIVERSAL_OUTPUTFOLDER}/"

echo "Combining executables"
rm "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework/${TARGET_NAME}"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework/${TARGET_NAME}" "${SIM_SDK_PATH}/${TARGET_NAME}.framework/${TARGET_NAME}" "${OS_SDK_PATH}/${TARGET_NAME}.framework/${TARGET_NAME}"
