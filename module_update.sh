#!/bin/bash - 

echo "更新子模块......"
git submodule update
git submodule foreach git pull origin master


