if [[ $ISOLATED_PATH -eq 1 ]]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games"
fi
unset ISOLATED_PATH
export PATH="$PATH:/opt/wine64/bin:/opt/wine32/bin"

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
