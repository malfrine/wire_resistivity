forfiles /s /m *.xlsx /c "cmd /c echo @relpath" | findstr /v /i "summary" | findstr /v /i "vinay" >> locs.txt