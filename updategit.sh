#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Vui lòng chạy script này với quyền root (sudo)."
    exit 1
fi

apt update -y
apt upgrade git -y

if git --version; then
    echo "Git đã được cập nhật thành công!"
else
    echo "Cập nhật Git thất bại. Vui lòng kiểm tra lại."
    exit 1
fi
