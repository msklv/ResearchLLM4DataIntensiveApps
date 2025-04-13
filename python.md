# Python и среда разработки

## Установка Python на Mac

Установка Python с помощью Homebrew
+ проверка.
```bash
brew install python
python3 --version
```
Если установлен, то обновляем:
```bash
brew update
brew upgrade python
python3 --version
```

Часто в системе есть несколлко версий Python,
выводим их:
```bash
ls -l /opt/homebrew/bin/python*
```


## Установка виртуального окружения с нужной версией Python
`virtualenv` или `venv`
```bash
/opt/homebrew/bin/python3.13 -m venv rag_env
source rag_env/bin/activate
```

### Как выключить виртуальное окружение
```bash
deactivate
```

