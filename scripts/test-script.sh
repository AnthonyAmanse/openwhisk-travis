#!/bin/bash

cat "${HOME}"/.wskprops

wsk -i list
wsk -i action create test-echo echo.js
wsk -i action invoke test-echo --param test test --result
