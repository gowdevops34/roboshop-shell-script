CHECK_ROOT() {
  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]; then
    echo -e "\e[3mYou should run this script as root user or sudo this script\e[0m"
    exit 1
  fi
}