if [[ $ISOLATED_PATH -eq 1 ]]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games"
fi
unset ISOLATED_PATH
# 优先使用32位的
export PATH="$PATH:/opt/wine32/bin:/opt/wine64/bin"

if [[ $CLEAR_ANDROID_ENV -eq 1 ]]; then
  unset ANDROID_DATA
  unset ANDROID_I18N_ROOT
  unset ANDROID_ROOT
  unset ANDROID_TZDATA_ROOT
  unset ANDROID_ART_ROOT
  unset EXTERNAL_STORAGE
  unset DEX2OATBOOTCLASSPATH
  unset BOOTCLASSPATH
fi
unset CLEAR_ANDROID_ENV
