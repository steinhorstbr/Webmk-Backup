RED='\033[0;31m'
NC='\033[0m'

border () {
    local str="$*"      # Put all arguments into single string
    local len=${#str}
    local i
    printf "\n"
    for (( i = 0; i < len + 4; ++i )); do
        printf '-'
    done
    printf "\n| $str |\n"
    for (( i = 0; i < len + 4; ++i )); do
        printf '-'
    done
    printf "\n"
    echo
}

#Проверяем ключи установки
while [ -n "$1" ]
do
case "$1" in
--fullinstall) fullinstall=1 ;;
--advanced) advanced=1 ;;
--help) help=1;;
esac
shift
done

#Показываем справку
if [[ $help == "1" ]]
then
	echo "Script de instalação automática do Real Mikrotik Backup"
	echo;echo "Uso: install.sh [OPÇÕES]"
	echo; echo "Descrição chave"
	echo "--fullinstall	Inicia o tempo de execução do Docker e o processo de pré-instalação do Docker Compose"
	echo "--advanced	Inicia contêineres com configurações avançadas alternativas. Principalmente para o desenvolvimento"
	exit 0
fi

#Устанавливаем Docker и Docker Compose
if [[ $fullinstall == "1" ]]
then
	border Instalando Docker e Docker Compose
	./scripts/dockerinstall.sh
fi

#Копируем файл переменных
cp .env.sample .env

#Запрашиваем данные для заполнения файла .env
border Configurando variáveis ​​para .env
./scripts/envfill.sh

#Запуск контейнеров
border Executando contêineres Docker
if [[ $advanced == "1" ]]
then
	docker-compose -f docker-compose-advanced.yml up --build -d
else
	docker-compose up --build -d
fi

#Инициализация базы данных
border Inicializando o banco de dados
while :
do
	sleep 5
	docker exec -it rmb-web yii migrate --interactive=0
	if [[ $? -eq 0 ]]
	then
		break
	else
		continue
	fi
done

#Установка владельца на папку web файлоы
border Configurando direitos de acesso à pasta de arquivos da web
chown -R www-data:www-data ./app/

#Запуск скрипта установки учетной записи администартора
border Configurando uma conta de administrador na interface da web
./scripts/webadminchange.sh
