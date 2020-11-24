# LocalizationHelper

# Программа локализатор-помощник

### Сборка проекта
> 
    git clone https://github.com/Solovey42/LocalizationHelper
    cd LocalizationHelper/Sources/LocalizationHelper
    swift build 
### Запуск проекта
> 
    
    SUBCOMMANDS:
      search                  Start search
      update                  Update selected item.
      delete                  Delete selected item.
    
    USAGE: 
      search [--key <key>] [--language <language>]
      update [<word>] [--key <key>] [--language <language>]
      delete [--key <key>] [--language <language>]
    
    OPTIONS:
      -k, --key <key>           The word to translate into. 
      -l, --language <language> Language into which we translate 
      <word>                    The word to update
      -h, --help                Show help information.

