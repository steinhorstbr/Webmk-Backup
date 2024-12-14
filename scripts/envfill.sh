RED='\033[0;31m'
NC='\033[0m'

while :
do
	read -r -s -p "Digite a senha do usuário MySQL " MYSQL_PASSWORD
	if [[ $MYSQL_PASSWORD != "" ]]
	then
		sed -i "s/^MYSQL_PASSWORD.*$/MYSQL_PASSWORD=$MYSQL_PASSWORD/g" .env
		echo
		break
	else
		echo; echo -e "${RED}A senha não pode ficar vazia${NC}"
		continue
	fi
done

while :
do
	read -r -s -p "Digite a senha do usuário ROOT do MariaDB: " MARIADB_ROOT_PASSWORD
	if [[ $MARIADB_ROOT_PASSWORD != "" ]]
	then
		sed -i "s/^MARIADB_ROOT_PASSWORD.*$/MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD/g" .env
		echo
		break
	else
		echo; echo -e "${RED}A senha não pode ficar vazia${NC}"
		continue
	fi
done

while :
do
        read -r -p "Quer usar criptografia para as senhas do seu banco de dados? [Y\n] " DATA_ENCRYPT
        if [[ $DATA_ENCRYPT =~ ^(Y|y)$ ]]
        then
                while :
                do
                        read -r -s -p "Digite a senha de criptografia: " DATA_ENCRYPT_PASSWORD
                        if [[ $DATA_ENCRYPT_PASSWORD != "" ]]
                        then
                                sed -i "s/^#\?DATA_ENCRYPT_PASSWORD.*$/DATA_ENCRYPT_PASSWORD=$DATA_ENCRYPT_PASSWORD/g" .env
                                echo
                                break 2
                        else
                                echo; echo -e "${RED}A senha não pode ficar vazia${NC}"
                                continue
                        fi
                done
        elif [[ $DATA_ENCRYPT =~ ^(N|n)$ ]]
        then
                sed -i "s/^DATA_ENCRYPT_PASSWORD.*$/#DATA_ENCRYPT_PASSWORD=/g" .env
                break
        else
                echo -e "${RED}Faça a escolha certa${NC}"
                continue
        fi
done

while :
do
	read -r -p "Deseja usar backups baseados em exportações? [Y\n] " MK_BACKUP_EXPORT
	if [[ $MK_BACKUP_EXPORT =~ ^(Y|y)$ ]]
	then
		sed -i "s/^MK_BACKUP_EXPORT.*$/MK_BACKUP_EXPORT=true/g" .env
		break
	elif [[ $MK_BACKUP_EXPORT =~ ^(N|n)$ ]]
	then
		sed -i "s/^MK_BACKUP_EXPORT.*$/MK_BACKUP_EXPORT=false/g" .env
		break
	else
		echo -e "${RED}Escolha${NC}"
		continue
	fi
done


if [[ $MK_BACKUP_EXPORT =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Deseja usar o parâmetro HIDE_SENSITIVE ao exportar? [Y\n] " MK_BACKUP_HIDE_SENSITIVE
		if [[ $MK_BACKUP_HIDE_SENSITIVE =~ ^(Y|y)$ ]]
		then
			sed -i "s/^MK_BACKUP_HIDE_SENSITIVE.*$/MK_BACKUP_HIDE_SENSITIVE=true/g" .env
			break
		elif [[ $MK_BACKUP_HIDE_SENSITIVE =~ ^(N|n)$ ]]
		then
			sed -i "s/^MK_BACKUP_HIDE_SENSITIVE.*$/MK_BACKUP_HIDE_SENSITIVE=false/g" .env
			break
		else
		echo -e "${RED}Escolha${NC}"
			continue
		fi
	done
fi

while :
do
	read -r -p "Enviar backups de exportação para o Git? [Y\n] " GIT_USING
	if [[ $GIT_USING =~ ^(Y|y)$ ]]
	then
		sed -i "s/^GIT_USING.*$/GIT_USING=true/g" .env
		break
	elif [[ $GIT_USING =~ ^(N|n)$ ]]
	then
		sed -i "s/^GIT_USING.*$/GIT_USING=false/g" .env
		break
	else
		echo -e "${RED}Escolha${NC}"
		continue
	fi
done

if [[ $GIT_USING =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Especifique o URL do repositório Git: " GIT_URL
		if [[ $GIT_URL != "" ]]
		then
			sed -i "s~^GIT_URL.*$~GIT_URL=$GIT_URL~g" .env
			break
		else
		echo -e "${RED}O valor não deve estar vazio${NC}"
			continue
		fi
	done
fi

if [[ $GIT_USING =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Forneça um nome de usuário para fazer login no repositório Git: " GIT_USER
		if [[ $GIT_USER != "" ]]
		then
			sed -i "s/^GIT_USER.*$/GIT_USER=$GIT_USER/g" .env
			break
		else
		echo -e "${RED}O valor não deve estar vazio${NC}"
			continue
		fi
	done
fi

if [[ $GIT_USING =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -s -p "Especifique a senha para autorização no repositório Git: " GIT_PASSWORD
		if [[ $GIT_PASSWORD != "" ]]
		then
			sed -i "s/^GIT_PASSWORD.*$/GIT_PASSWORD=$GIT_PASSWORD/g" .env
			echo
			break
		else
		echo; echo -e "${RED}O valor não deve estar vazio${NC}"
			continue
		fi
	done
fi

if [[ $GIT_USING =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Especifique o valor para o campo user.name: " GIT_CONFIG_USERNAME
		if [[ $GIT_CONFIG_USERNAME != "" ]]
		then
			sed -i "s/^GIT_CONFIG_USERNAME.*$/GIT_CONFIG_USERNAME=$GIT_CONFIG_USERNAME/g" .env
			break
		else
		echo -e "${RED}O valor não deve estar vazio${NC}"
			continue
		fi
	done
fi

if [[ $GIT_USING =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Especifique o valor para o campo user.mail: " GIT_CONFIG_USERMAIL
		if [[ $GIT_CONFIG_USERMAIL != "" ]]
		then
			sed -i "s/^GIT_CONFIG_USERMAIL.*$/GIT_CONFIG_USERMAIL=$GIT_CONFIG_USERMAIL/g" .env
			break
		else
		echo -e "${RED}O valor não deve estar vazio${NC}"
			continue
		fi
	done
fi

while :
do
	read -r -p "Você deseja usar backups binários? [Y\n] " MK_BACKUP_BINARY
	if [[ $MK_BACKUP_BINARY =~ ^(Y|y)$ ]]
	then
		sed -i "s/^MK_BACKUP_BINARY.*$/MK_BACKUP_BINARY=true/g" .env
		break
	elif [[ $MK_BACKUP_BINARY =~ ^(N|n)$ ]]
	then
		sed -i "s/^MK_BACKUP_BINARY.*$/MK_BACKUP_BINARY=false/g" .env
		break
	else
		echo -e "${RED}O valor não deve estar vazio${NC}"
		continue
	fi
done

if [[ $MK_BACKUP_BINARY =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Você deseja usar criptografia para backups binários? [Y\n] " MK_BACKUP_ENCRYPT
		if [[ $MK_BACKUP_ENCRYPT =~ ^(Y|y)$ ]]
		then
			while :
			do
				read -r -s -p "Digite sua senha de criptografia: " MK_BACKUP_ENCRYPT_PASSWORD
				if [[ $MK_BACKUP_ENCRYPT_PASSWORD != "" ]]
				then
					sed -i "s/^#\?MK_BACKUP_ENCRYPT_PASSWORD.*$/MK_BACKUP_ENCRYPT_PASSWORD=$MK_BACKUP_ENCRYPT_PASSWORD/g" .env
					echo
					break 2
				else
					echo; echo -e "${RED}A senha não pode ficar vazia${NC}"
					continue
				fi
			done
		elif [[ $MK_BACKUP_ENCRYPT =~ ^(N|n)$ ]]
		then
			sed -i "s/^MK_BACKUP_ENCRYPT_PASSWORD.*$/#MK_BACKUP_ENCRYPT_PASSWORD=/g" .env
			break
		else
		echo -e "${RED}Faça a escolha certa${NC}"
			continue
		fi
	done
fi

while :
do
	read -r -p "Excluir automaticamente arquivos de backup binários antigos? [Y\n] " PURGE_OLD_BACKUP
	if [[ $PURGE_OLD_BACKUP =~ ^(Y|y)$ ]]
	then
		sed -i "s/^PURGE_OLD_BACKUP.*$/PURGE_OLD_BACKUP=true/g" .env
		break
	elif [[ $PURGE_OLD_BACKUP =~ ^(N|n)$ ]]
	then
		sed -i "s/^PURGE_OLD_BACKUP.*$/PURGE_OLD_BACKUP=false/g" .env
		break
	else
		echo -e "${RED}Escolha${NC}"
		continue
	fi
done

if [[ $PURGE_OLD_BACKUP =~ ^(Y|y)$ ]]
then
	while :
	do
		read -r -p "Quantas últimas cópias devo manter durante a exclusão automática? [число] " PURGE_N_PIECE
		if [[ $PURGE_N_PIECE -ge 1 ]]
		then
			sed -i "s/^PURGE_N_PIECE.*$/PURGE_N_PIECE=$PURGE_N_PIECE/g" .env
			break
		else
		echo -e "${RED}Digite um número maior que 1${NC}"
			continue
		fi
	done
fi
