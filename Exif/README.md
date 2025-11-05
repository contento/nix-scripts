## Using exiftool

Use exiftool to organize your assets by date (year/month/day).

[exiftool](https://exiftool.org/)

```shell
# Specify the folder containing your assets
folder='./assets/photos/todo'

# Show date information
exiftool -r -time:all -a -G0:1 -s "$folder"

# Organize into folders by date
exiftool -r -d "%Y/%m/%d" "-Directory<FileModifyDate" "-Directory<CreateDate" "-Directory<DateTimeOriginal" "$folder"
``
