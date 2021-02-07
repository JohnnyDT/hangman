#! /bin/bash

# subor zo zoznamom slov
subor_fraz="zoznam_slov.txt"

NC='\033[0m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RED1='\033[0m'
RED2='\033[0m'
GREEN='\033[0;32m'


# importovane subory
. grafika.sh

# vymazanie obrazovky
printf "\033c"

# ---------------------------------------------------------------------------
# hladanie v subore
function pocetFrazVsubore {
    pocet_fraz_v_subore=`wc -l $subor_fraz | cut -d " " -f1`
    #echo "Pocet fraz v subore:" $pocet_fraz_v_subore
}

# najdenie nahodnej frazy zo suboru
function vyberFrazyZoSuboru {
    cislo_frazy=$(((RANDOM % pocet_fraz_v_subore)+1))
    #echo "Cislo vybratej frazy: " $cislo_frazy

    #echo ""
	#echo -e "${BLUE}Zoznam slov v subore: slova.txt${NC}"
	#echo ""

	cisloRiadku=0;

    while IFS= read -r line;do
		let cisloRiadku++		

		if [[ cisloRiadku -eq cislo_frazy ]]; then
			fraza=$line
            #echo $cisloRiadku $line
			#echo -e ${RED} "---> nasiel som!" ${NC}
		#else
			#echo $cisloRiadku $line
		fi
	done < "$subor_fraz"

    #echo ""
    #echo $fraza
}
# ---------------------------------------------------------------------------
# funkcia na vypisanie frazy po pismenkach
# prvy a posledny znak zobrazi a nahradi ho 1kou ako najdena fraza

function nastavenieFrazy {
	#echo ""
	#echo -e "Najdena fraza: ${RED}${fraza}${NC}"
	foo=$fraza

	for (( i=0; i<${#foo}; i++ )); do

        pismenka[$i]=${foo:$i:1};

	    if [[ i -eq 0 ]] || [[ i -eq ${#foo}-1 ]]; then
            stav_uhadnutych_pismen[$i]="1";            
	  	    #printf "${foo:$i:1} "            
	    else
            if [[ ${pismenka[$i]} == ' ' ]]; then
                stav_uhadnutych_pismen[$i]="1";
	  	        #printf "  "          
	        else
                stav_uhadnutych_pismen[$i]="0";
	  	        #printf "_ "
            fi
	    fi     

	done
}

function vypisFrazy() {
    cislo=0

    printf "${PRE}"

    for i in "${stav_uhadnutych_pismen[@]}"; do
        if [[ ${i} -eq 1 ]]; then
            printf "${pismenka[$cislo]} " 
        else
            printf "_ "
        fi

        let cislo++
    done
} 

function vypisPola() {
    echo ""
    arr=("$@")
    for i in "${arr[@]}"; do
        printf "$i"
    done
}

function hadajPismeno {
    echo ""
    echo ""
    echo -e "${GREEN}Hadaj pismenko:${NC}"
    read -p "" PISMENO
    PISMENO=${PISMENO:0:1}
}

function kontrolaPismena {
    #echo ""
    #echo "-----------------------------"
    #echo -e "Zadane pismeno: ${RED}${PISMENO}${NC}"
    cislo=0 
    uhadnute_pismeno=false

    for i in "${pismenka[@]}"; do
        #printf "$i"             

        if [[ $i == $PISMENO ]] && [[ ${stav_uhadnutych_pismen[cislo]} -eq 0 ]]; then
	  	    #printf "\n nasiel som \n"
            stav_uhadnutych_pismen[cislo]="1";
            let uhadnute_pismeno=true
            UHADNUTIE=true
	    fi	
        let cislo++ 
    done
    
    if [[ "${uhadnute_pismeno}" = false ]] ; then
        let pocet_neuhadnutych_pismen++
        UHADNUTIE=false
        #echo ""
	  	#echo "NEUHADOL SI"
    fi

    #echo "-----------------------------"
}

function kontrolaPola {
    vyhra=true

    for i in "${stav_uhadnutych_pismen[@]}"; do
        if [[ ${i} -eq 0 ]]; then
            let vyhra=false 
            break       
        fi
    done

   # if [[ ${vyhra} == true ]]; then
   #     vyhra
   # fi
} 

# ----------------HRA---------------
function zacniHru {

    # zistenie a vypis vytiahnutej frazy zo suboru
    pocetFrazVsubore
    vyberFrazyZoSuboru
    nastavenieFrazy 

    #vypisPola "${pismenka[@]}"
    #vypisPola "${stav_uhadnutych_pismen[@]}"

    pocet_neuhadnutych_pismen=0
    POCET=9    
    sum=$(expr "${#foo}" - "2")
    
    while [[ $pocet_neuhadnutych_pismen -lt 10 ]]
    do
        printf "\033c"
        pocetChybnychPokusov=${pocet_neuhadnutych_pismen}
        
        hadanie        
        vypisFrazy

        if [[ ${pocet_neuhadnutych_pismen} -eq 9 ]]; then
            echo " "
            echo " "
            prehra
            exit 1
        fi

        if [[ ${vyhra} == true ]]; then
            printf "\033c"
            hadanie
            vypisFrazy
            echo " "
            echo " "
            vyhra
        fi

        hadajPismeno
        #printf "\033c"
        kontrolaPismena
        #vypisPola "${pismenka[@]}"
        #vypisPola "${stav_uhadnutych_pismen[@]}"
        echo ""
        #echo "Pocet chybnych pokusov: ${pocet_neuhadnutych_pismen} !"
        POCET=$(expr "9" - "${pocet_neuhadnutych_pismen}")
        #echo "$POCET"

        kontrolaPola
    done    
}

uvodnaObrazovka
MENU=0

while [ $MENU != 3 ]
do    
   
    menuHry
    read -p "" MENU

    case "${MENU}" in
        1) 
            zadajMeno
            zacniHru
            ;;
        2) 
            pridavanieSlova
            ;;
        3) 
            echo "Dovidenia!"
            echo ""
            exit 1
            ;;
        *)  
            echo "Zadali ste zlu volbu!"
            echo ""
            ;;
    esac
done