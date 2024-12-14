RED='\033[0;31m'
NC='\033[0m'

while :
do
	read -r -p "Digite seu login:" USERNAME
	if [[ "$USERNAME" != "" ]]
	then
		while :
		do
			read -r -s -p "Digite a senha: " PASSWORD
			if [[ "$PASSWORD" != "" ]]
			then
				sed -i "s/'username' => '.*$/'username' => '$USERNAME',/g; s/'password' => '.*$/'password' => '$PASSWORD',/g"  app/models/User.php
				break 2
			else
				echo; echo -e "${RED}A senha não pode ficar vazia${NC}"
				continue
			fi
		done
	else
		echo -e "${RED}O login não pode ficar vazio${NC}"
		continue
	fi
done
