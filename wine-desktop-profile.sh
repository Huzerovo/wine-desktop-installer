if [[ $ISOLATED_PATH -eq 1 ]]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games"
  PATH="$PATH:/opt/wine/bin"
  export PATH
fi

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
