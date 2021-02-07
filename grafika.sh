#! /bin/bash

#farby na zvyraznenie textu
NC='\033[0m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RED1='\033[0m'
RED2='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'

# vymazanie obrazovky
printf "\033c"

# subor zo zoznamom slov
subor_fraz="zoznam_slov.txt"

# obrazovka hry
function uvodnaObrazovka {
    printf "\033c"

    echo " .------------------------------------------------------------. "
    echo "|                              |                               |"
    echo "|   ___________                |                               |" 
    echo "|   |  /      |                |                               |"  
    echo -e "|   | /       |                |         ${GREEN}W E L C O M E${NC}         |"  
    echo "|   |/        O                |                               |"    
    echo -e "|   |        /|\               |              ${GREEN}T O${NC}              |"   
    echo "|   |         |                |                               |"  
    echo -e "|   |        / \               |      ${GREEN}H  A  N  G  M  A  N${NC}      |"   
    echo "|   |                          |      -  -  -  -  -  -  -      |" 
    echo "|   |____________              |                               |"     
    echo "|   |            |_            |                               |"      
    echo "|   |              |_          |                               |"       
    echo "|   |                |_        |                               |"       
    echo "|   |__________________|       |                               |"  
    echo -e "|                              |             ${PURPLE}HANGMAN by Johnny${NC} |"    
    echo " '------------------------------------------------------------' "
    echo " "
    echo -e "          ${RED}Pre pokracovanie stlacte ENTER klavesu!${NC}           "
    read -p "" NIC
}

function menuHry {
    printf "\033c"

    echo " .------------------------------------------------------------. "
    echo "|                              |                               |"
    echo -e "|   ___________                |      ${GREEN}H  A  N  G  M  A  N${NC}      |"  
    echo "|   |  /      |                |                               |"  
    echo "|   | /       |                |         M E N U               |"  
    echo "|   |/        O                |         - - - -               |"    
    echo "|   |        /|\               |         1. NEW GAME           |"   
    echo "|   |         |                |         2. ADD NEW WORLD      |"  
    echo "|   |        / \               |         3. EXIT               |"   
    echo "|   |                          |                               |" 
    echo "|   |____________              |                               |"     
    echo "|   |            |_            |                               |"      
    echo "|   |              |_          |                               |"       
    echo "|   |                |_        |                               |"       
    echo "|   |__________________|       |                               |"  
    echo -e "|                              |             ${PURPLE}HANGMAN by Johnny${NC} |"    
    echo " '------------------------------------------------------------' "
}

function zadajMeno {
    printf "\033c"

    echo " .------------------------------------------------------------. "
    echo "|                              |                               |"
    echo -e "|   ___________                |      ${GREEN}H  A  N  G  M  A  N${NC}      |"
    echo "|   |  /      |                |      -  -  -  -  -  -  -      |"   
    echo "|   | /       |                |                               |"  
    echo "|   |/        O                |                               |"    
    echo "|   |        /|\               |      Z A D A J   M E N O      |"  
    echo "|   |         |                |                               |"  
    echo "|   |        / \               |                               |"   
    echo "|   |                          |                               |" 
    echo "|   |____________              |                               |"     
    echo "|   |            |_            |                               |"      
    echo "|   |              |_          |                               |"       
    echo "|   |                |_        |                               |"       
    echo "|   |__________________|       |                               |"  
    echo -e "|                              |             ${PURPLE}HANGMAN by Johnny${NC} |"    
    echo " '------------------------------------------------------------' "
    
    # zadanie mena hraca
    function zadajMeno {
        echo -e "${BLUE}Zadajte meno hraca:${NC}"
        echo -e "${BLUE}-------------------${NC}"
        read -p "" MENO
        MENO_POCET_ZNAKOV=${#MENO}      
    }
    zadajMeno
}

function pridavanieSlova {
    printf "\033c"

    echo " .------------------------------------------------------------. "
    echo "|                              |                               |"
    echo -e "|   ___________                |      ${GREEN}H  A  N  G  M  A  N${NC}      |"  
    echo "|   |  /      |                |      -  -  -  -  -  -  -      |"   
    echo "|   | /       |                |                               |"  
    echo "|   |/        O                |                               |"    
    echo "|   |        /|\               |      P R I D A V A N I E      |"  
    echo "|   |         |                |                               |"  
    echo "|   |        / \               |           S L O V A           |"   
    echo "|   |                          |                               |" 
    echo "|   |____________              |                               |"     
    echo "|   |            |_            |                               |"      
    echo "|   |              |_          |                               |"       
    echo "|   |                |_        |                               |"       
    echo "|   |__________________|       |                               |"  
    echo -e "|                              |             ${PURPLE}HANGMAN by Johnny${NC} |"   
    echo " '------------------------------------------------------------' "

    # pridanie slova do suboru
    function pridajFrazuDoSuboru {
        echo -e "${BLUE}Zadajte novu frazu:${NC}"
        echo -e "${BLUE}-------------------${NC}"
        read -p "" NOVA_FRAZA
        echo ${NOVA_FRAZA} >> ${subor_fraz}
        echo -e "${BLUE}-------------------${NC}"
        echo -e "Fraza \"${BLUE}${NOVA_FRAZA}${NC}\" bola ulozena do suboru ${BLUE}${subor_fraz}${NC} !"
        echo ""
    }
    pridajFrazuDoSuboru
}

obs01=" "
obs02=" "
obs03=" "
obs04=" "
obs05=" "
obs06=" "
obs07=" "
obs08=" "
obs09=" "

function hadanie {    

    function vykreslenieObesenca {
        case "$pocetChybnychPokusov" in
            1) 
                obs01="|"
                ;;
            2) 
                obs02="|"
                ;;
            3) 
                obs03="O"
                ;;
            4) 
                obs04="/"
                ;;
            5) 
                obs05="|" 
                ;;
            6) 
                obs06="\\"
                ;;
            7) 
                obs07="|"
                ;;
            8) 
                obs08="/"
                ;;
            9) 
                obs09="\\"
                ;;        
        esac
    }

    vykreslenieObesenca

    if [[ "${UHADNUTIE}" = true ]] ; then
        VYPIS="${GREEN}Uhadol si pismeno !         ${NC}|"
    else
        VYPIS="${RED}Neuhadol si pismeno !       ${NC}|"
    fi

    function medzera {
        pom=$(expr 22 - "${#MENO}")
        pom1=" "
        pom2="|"
        PREM=""
        for (( i=1; i<=$pom; i++ )); 
        do 
            PREM="${PREM}${pom1}"
        done
        PREM="${PREM}${pom2}" 
    }
    medzera    

    echo -e " .------------------------------------------------------------."
    echo -e "|                              |                               |" 
    echo -e "|   ___________                |      ${GREEN}H  A  N  G  M  A  N${NC}      |"  
    echo -e "|   |  /      ${RED}$obs01${NC}                |      -  -  -  -  -  -  -      |"     
    echo -e "|   | /       ${RED}$obs02${NC}                |                               |"
    echo -e "|   |/        ${RED}$obs03${NC}                |                               |"     
    echo -e "|   |        ${RED}$obs04$obs05$obs06               ${NC}|   ${BLUE}HRAC: ${MENO}${NC}${PREM}" 
    echo -e "|   |         ${RED}$obs07${NC}                |                               |"   
    echo -e "|   |        ${RED}$obs08 $obs09               ${NC}|   ${VYPIS}                               "   
    echo -e "|   |                          |                               |"  
    echo -e "|   |____________              |   Ostava pokusov: ${RED}${POCET}${NC}.          |"     
    echo -e "|   |            |_            |                               |"       
    echo -e "|   |              |_          |                               |"        
    echo -e "|   |                |_        |                               |"        
    echo -e "|   |__________________|       |                               |"   
    echo -e "|                              |             ${PURPLE}HANGMAN by Johnny${NC} |"    
    echo -e " '------------------------------------------------------------''"
}

function vyhra {
    
    echo "██╗   ██╗ ██████╗ ██╗   ██╗    ██╗    ██╗██╗███╗   ██╗    ██╗"
    echo "╚██╗ ██╔╝██╔═══██╗██║   ██║    ██║    ██║██║████╗  ██║    ██║"
    echo " ╚████╔╝ ██║   ██║██║   ██║    ██║ █╗ ██║██║██╔██╗ ██║    ██║"
    echo "  ╚██╔╝  ██║   ██║██║   ██║    ██║███╗██║██║██║╚██╗██║    ╚═╝"
    echo "   ██║   ╚██████╔╝╚██████╔╝    ╚███╔███╔╝██║██║ ╚████║    ██╗"
    echo "   ╚═╝    ╚═════╝  ╚═════╝      ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝    ╚═╝"

    exit 1
}

function prehra {

    echo "██╗   ██╗ ██████╗ ██╗   ██╗    ██╗      ██████╗ ███████╗███████╗    ██╗"
    echo "╚██╗ ██╔╝██╔═══██╗██║   ██║    ██║     ██╔═══██╗██╔════╝██╔════╝    ██║"
    echo " ╚████╔╝ ██║   ██║██║   ██║    ██║     ██║   ██║███████╗█████╗      ██║"
    echo "  ╚██╔╝  ██║   ██║██║   ██║    ██║     ██║   ██║╚════██║██╔══╝      ╚═╝"
    echo "   ██║   ╚██████╔╝╚██████╔╝    ███████╗╚██████╔╝███████║███████╗    ██╗"
    echo "   ╚═╝    ╚═════╝  ╚═════╝     ╚══════╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝"

    exit 1
}