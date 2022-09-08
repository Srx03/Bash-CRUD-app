#!/bin/sh 
adminPocetni () {
    echo "1) Kreiranje_pacijenta"
    echo "2) Editovanje_pacijenta"
    echo "3) Brisanje_pacijenta"
    echo "4) Ispis_liste"
    echo "5) Kreiranje_odjela"
    echo "6) Exit"
}
editPocetni () {
    echo "1) Ime"
    echo "2) Prezime"
    echo "3) Adresa"
    echo "4) JMBG"
    echo "5) Analiza"
    echo "6) Exit"
}
korisnikPocetni () {
    echo "1) Ispis kartona"
    echo "2) Zahtjev za prijem na odjel"
    echo "3) Prikaz trenutnih kapaciteta na odjelima"
    echo "4) Exit"
}
adminpass=admin
adminuser=admin
crtice=" --- "
test=1
test1=1
m=0
pomocna=0
brojKorisnika=1
korisnik1=korisnik1
korisnik1pass=korisnik1
i=0
o=0
v=0
while true
do
test1=1
m=0
echo "Unesite korsničko ime"
read user
echo "Unesite vašu lozinku"
read pass
if [ $user == $adminuser -a $pass == $adminpass ]
then
echo "uspješno ste se logovali"
echo "odaberite željenu opciju"
while true
do
adminPocetni
read odabirAdmin
case $odabirAdmin in
 1)
        echo "Unesite ime pacijenta"
        read ime[i]
        echo "Unesite prezime pacijenta"
        read prezime[i]
        echo "Unesite adresu pacijenta"
        read adresa[i]
        echo "Unesite JMBG"
        read JMBG[i]
        echo "Unesite analizu"
        read analiza[i]
        echo "Unesite username"
        read korisnikUser[i]
        echo "Unesite sifra"
        read korisnikPass[i]
        korsnikId[i]="$i"
        ((i++))
        m=1
        brojKorisnika=i
       ;;
2)
        echo "Unesite redni broj pacijenta kojeg želite editovat"
         for((z=0;z<i;z++))
        do
               echo "${korsnikId[z]}. ${ime[z]} ${prezime[z]} ${adresa[z]} ${JMBG[z]} ${analiza[z]} "
        done
        read rbEdit
        echo "Odaberite šta želite editovati"
        while true
        do
        editPocetni
        read editOdabir
         case $editOdabir in
                1)
                    echo "Unesite novo Ime"
                    read novoIme
                    ime[rbEdit]=$novoIme;;
                2)
                    echo "Unesite novo Prezime"
                    read novoPrezime
                    prezime[rbEdit]=$novoPrezime;;
                3)
                    echo "Unesite novu Adresu"
                    read novaAdresa
                    adresa[rbEdit]=$novaAdresa;;
                4)
                    echo "Unesite novi JMBG"
                    read noviJMBG
                    JMBG[rbEdit]=$noviJMBG;;
                5)
                    echo "Unesite novu Analizu"
                    read novaAnaliza
                    analiza[rbEdit]=$novaAnaliza;;
                6)
                    break;;
                *)
                    echo "Pogrešan unos";;
                esac
        done
        ;;
3)      echo "Unesite redni broj pacijenta kojeg želite obrisati"
         for((z=0;z<i;z++))
        do
               echo "${korsnikId[z]}. ${ime[z]} ${prezime[z]} ${adresa[z]} ${JMBG[z]} ${analiza[z]} "
        done
        read rbDelete
          unset ime[rbDelete]
          unset prezime[rbDelete]
          unset adresa[rbDelete]
          unset JMBG[rbDelete]
          unset analiza[rbDelete]
          unset korisnikUser[rbDelete]
          unset korisnikPass[rbDelete]
                        echo "Korisnik: ${ime[rbDelete]} ${prezime[rbDelete]} uspješno obrisan!"

        ;;
4)
       for((z=0;z<i;z++))
        do
               echo "${korsnikId[z]}. ${ime[z]} ${prezime[z]} ${adresa[z]} ${JMBG[z]} ${analiza[z]}"
               echo "---------------------------"
        done
       m=1;;
5)
        echo "Unesite naziv odjela"
read odjel[o]
        echo "Odjel ${odjel[o]} uspješno kreiran!"
        ((o++))
        m=1;;
6)
       break
       m=1;;
*)
        echo "Nepoznat unos odabira";;
esac
done
else
         for((k=0;k<brojKorisnika;k++))
        do
            if [ $user == ${korisnikUser[k]} -a $pass == ${korisnikPass[k]} ]
            then
            pomocna=1
                while true
                do
                korisnikPocetni
                read odabirKorisnik
                case $odabirKorisnik in
                    1)
                        echo "Ime: ${ime[k]}"
                        echo "Prezime: ${prezime[k]}"
                        echo "Adresa: ${adresa[k]}"
                        echo "JMBG: ${JMBG[k]}"
                        echo "Analiza: ${analiza[k]}"
                        ;;
                    2)
                        echo "Odaberite koji odjel želite"
                        for((c=0;c<o;c++))
                        do
                            echo "${c}. ${odjel[c]}"
                        done
                        read odabirOdjel
                        if [ ${odjelPomocna[odabirOdjel]} -eq 1 ]
                            then
                                odjelIspis[odabirOdjel]="${odjelIspis[odabirOdjel]} $crtice ${ime[k]} ${prezime[k]}"
                               echo "Uspiješno zakazan pregled za odjel ${odjel[odabirOdjel]} za ime ${ime[k]}"
                            else
                                 odjelIspis[odabirOdjel]="${odjel[odabirOdjel]} $crtice ${ime[k]} ${prezime[k]}"
                                echo "Uspiješno zakazan pregled za odjel ${odjel[odabirOdjel]} za ime ${ime[k]}"
                                odjelPomocna[odabirOdjel]=1
                            fi
                        ;;
                    3)
                        for((t=0;t<o;t++))
                        do
                          echo "${odjelIspis[t]}"
                        done
                        ;;
                    4)
                        pomocna=2;
                        break;;
                    *)
                        echo "Pogrešan unos";;
                esac
                done
            fi
        done
        if [ $pomocna -eq 0 ]
        then
        echo "Pogrešan unos šifre ili username-a"
        pomocna=0
        fi
        if [ $pomocna -eq 2 ]
        then
        echo "Hvala što koristite naše usluge"
        pomocna=0
        fi
fi
done
