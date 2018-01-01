#!/usr/bin/env bash
provisioners=$(whiptail --checklist "Select provisioners" 0 0 0 \
  "archilinux" "" OFF \
  "fedora" "" OFF \
  "ubuntu" "" OFF \
  "shared" "" OFF \
  "network" "" OFF 3>&1 1>&2 2>&3)

if [ "${?}" != "0" ]; then
  echo "Canceled."
fi

echo "Selected provisioners: ${provisioners}"
current_dir=$(dirname ${0})

for provisioner in ${provisioners}
do
  path=$(echo "${current_dir}/${provisioner}.sh" | sed 's/"//g')
  echo -e "\nRun ${path}"
  bash "${path}"

  if [ "${?}" != "0" ]; then
    echo "${path} is failed."
    exit 1
  fi
done
