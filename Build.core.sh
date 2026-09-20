# shellcheck disable=SC2154
MAKE_OVERRIDE_ARGS=("$@")
. "${scriptPWD}/Build.core.utils.sh"
. "${scriptPWD}/lib/kconfigs.sh"
. "${scriptPWD}/config/Default.sh"
envsetup
