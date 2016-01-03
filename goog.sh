lucky() {
        inputL="$*"
        inputL=${inputL// /+}
        echo "In Lucky"
        echo $inputL
        query=$( curl -s --get --data-urlencode "q=$inputL" http://ajax.googleapis.com/ajax/services/search/web?v=1.0 | sed 's/"unescapedUrl":"\([^"]*\).*/\1/;s/.*GwebSearch",//')
        echo $query
        google-chrome $query
}
google() {

    #Set up function/addons table
    regularSearch=1;
    declare -a addons
    declare -a addonsBool
    num_addons=2

    for ((i=1;i<=num_addons;i++)) do
        addonsBool[$i]=0
    done


    addons[1]="lucky"
    addons[2]="allasdasd"

    #Push input from all arguments into one string
    input="$*"

    #Check flags
    for i in $*
        do 	
	    case "$i" in 
	        -l | --lucky)
		addonsBool[1]=1
                input=${input//$i/}
                regularSearch=0
                echo "In Case Lucky"
                echo $input
    
		;;	
	    
                -a | --all)
		addonsBool[2]=1 
                regularSearch=0
                echo "In Case All"
                input=${input#$i}
		;;
			
		-i | --image| -m | --meme)
		#$meme=1
		#argRemove=i
		;;
			
		-y | --youtube)
		#$youtube=1
		#argRemove=i
	    esac
	done
    echo "Before Output"
    echo $input
    #lucky $input
    if [ $regularSearch -eq 0 ]
    then
        for ((i=1;i<=num_addons;i++)) do
            if [ ${addonsBool[$i]} -eq 1 ] 
            then
                echo "In Addons"
                ${addons[$i]} $input
            fi
        done
    else
        input=${input// /+}
        google-chrome https://www.google.com/search?q=$input
    fi
}
