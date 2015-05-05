Instalacja:

    vagrant up

Ze względu na to, że git może popsuć końcówki linii w plikach, przed instalacją na windows wykonujemy:

    git config core.autocrlf false
    dos2unix functions.sh
	
Po zakończeniu pracy:

    vagrant destroy