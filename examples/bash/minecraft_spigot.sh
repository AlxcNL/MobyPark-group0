#!/usr/bin/env bash

# Global variables

declare -a deps=(
    "curl"
    "gdebi"
    "gnupg"
    "openjdk-8-jdk-headless"
    "wget"
)

declare -a allowedActions=( 
    "setup"
    "minecraft"
    "spigotserver"
    "remove"
)

declare -a allowedOperations=( 
    "install"
    "test"
    "uninstall"
)

# Global variables
RED="31"
YELLOW="33"

# https://computingpost.medium.com/how-to-install-spigot-minecraft-server-on-ubuntu-20-04-19345734d70e
UPLOADED_FILES="."

function printInColor() {
    message=$1
    shift 1
    colorCode="$@"
    echo -e "\e[${colorCode}m${message}\e[0m"

}

function setEnvironmentVariables() {
    printInColor "function setEnvironmentVariables" $YELLOW

    config_filename="dev.conf"
    [[ $(uname -m) == "x86_64" ]] || config_filename="dev_arm64.conf"
    config_file="${UPLOADED_FILES}/$config_filename"
    # source $config_file
    echo $config_filename
    source $config_filename

    spigot_install_dir="${INSTALL_DIR}/server"
    minecraft_install_dir="${INSTALL_DIR}/client"

}

function printInColor() {
    # https://colors.sh/
    message=$1
    shift 1
    colorCode="$@"
    echo -e "\e[${colorCode}m${message}\e[0m"

}

# INSTALL

function install_with_apt() {
    # Do NOT remove next line!    
    printInColor "function install_with_apt" $YELLOW

    [[ -z $1 ]] && handle_error "Empty packagename"

    package=$1

    (
        sudo apt update && \
        sudo apt install -y "$package";
    ) || handle_error "Unable to install ${package}"

}

function remove_with_apt() {
    # Do NOT remove next line!    
    printInColor "function remove_with_apt" $YELLOW

    [[ -z $1 ]] && handle_error "Empty packagename"

    package=$1

    (
        sudo apt remove -y "$package";
    ) || handle_error "Unable to install ${package}"

    sudo apt autoclean -y

}

function install_package() {
    # Do NOT remove next line!
    printInColor "function install_package" $YELLOW

    # TODO read the arguments from $@
            # Make sure NOT to use empty argument values

    local package_name=$1
    local package_url=$2
    local package_dir=$3

    printf "package_name : %s\n" "${package_name}"
    printf "package_url : %s\n" "${package_url}"
    printf "package_dir : %s\n" "${package_dir}"

    # package_dir="${INSTALL_DIR}/${package_name}"
    package_file="${package_dir}/${package_name}"
    mkdir -p "$package_dir" || handle_error "Cannot create ${package_dir}"
    
    echo "Install ${package_name}"
    if [[ ! -f "${package_file}" ]]; then
        curl -o ${package_file} ${package_url} || handle_error "Unable to download ${package_url}"
    fi

    package_type="${package_name##*.}"

    case $package_type in

        "AppImage")
            cmd="chmod u+x $package_file";
            echo $cmd;
            eval $cmd || handle_error "Unable to install $package_file";
            ;;

        "deb")
            cmd="sudo gdebi --non-interactive ${package_file}";
            echo $cmd;
            eval $cmd || handle_error "Unable to install $package_file";
            rm $package_file;
            ;;

        "jar")
            cmd="java -jar $package_file"
            echo $cmd
            (
                cd $install_dir || handle_error "Cannot enter ${install_dir}"; 
                eval $cmd || handle_error "Unable to install $package_file";
            )
            
            ;;

        *)
            handle_error "Install package NOT implemented for type ${package_type}";
            ;;

    esac
   
}


# CONFIGURATION

# TODO complete the implementation of this function
# Make sure to use sudo only if needed
function configure_spigotserver() {
    # Do NOT remove next line!
    printInColor "function configure_spigotserver" $YELLOW

    # TODO Configure Firewall
        # make sure ufw has been installed    

    # TODO allow SSH port with ufw allow OpenSSH
        # use ufw to allow the port that is specified in dev.conf for the Spigot server to accept connections
        # make sure ufw has been enabled

    # TODO configure spigotserver to run creative gamemode instead of survival 
        # this can be done by running the sed command on the (automatically generated) file server.properties 
        # (https://minecraft.fandom.com/wiki/Server.properties)
        # with the argument 's/\(gamemode=\)survival/\1creative/'

    # TODO restart the spigot service

    # TODO if something goes wrong then call function handle_error

}

# TODO complete the implementation of this function
# Make sure to use sudo only if needed
function create_spigotservice() {
    # Do NOT remove next line!
    echo "function create_spigotservice"
    
    # TODO (manually) change the path to spigot directory in file spigot.service
    system_path="/etc/systemd/system/"
    service_name="spigot.service"
    
    # TODO if something goes wrong then call function handle_error
    sudo cp "${UPLOADED_FILES}/${service_name}" "$system_path"

    # TODO if something goes wrong then call function handle_error
    echo "Reload the service daemon"
    sudo systemctl daemon-reload

    # TODO if something goes wrong then call function handle_error
    sudo systemctl enable "$service_name"
    
}

# ERROR HANDLING

function handle_error() {
    # Do NOT remove next line!
    printInColor "function handle_error" $YELLOW
    printInColor "$1" $RED
    exit

}

# TODO complete the implementation of this function
# Make sure to use sudo only if needed
function rollback_spigotserver {
    # Do NOT remove next line!
    printInColor "function rollback_spigotserver" $YELLOW

    rm -rf "$INSTALL_DIR/server" || handle_error "Cannot remove $INSTALL_DIR.server"

}


# UNINSTALL

# Make sure to use sudo only if needed
function uninstall_minecraft {
    # Do NOT remove next line!
    printInColor "function uninstall_minecraft" $YELLOW

    # TODO remove the directory containing minecraft
    sudo apt-get remove minecraft-launcher || handle_error "minecraft-launcher could not be removed"

    rm -rf "$INSTALL_DIR/client" || handle_error "Cannot remove $INSTALL_DIR/client"

}

# TODO complete the implementation of this function
# Make sure to use sudo only if needed
function uninstall_spigotserver {
    # Do NOT remove next line!
    printInColor "function uninstall_spigotserver" $YELLOW
    rm -rf spigot_install_dir || handle_error "Unable to rm $spigot_install_dir"

}

# TODO complete the implementation of this function
# Make sure to use sudo only if needed
function uninstall_spigotservice {
    # Do NOT remove next line!
    printInColor "function uninstall_spigotservice" $YELLOW

    # TODO disable the spigotservice with systemctl disable
    # TODO delete /etc/systemd/system/spigot.service

    # TODO if something goes wrong then call function handle_error
    
}

# TODO complete the implementation of this function
# Make sure to use sudo only if needed
function remove() {
    # Do NOT remove next line!
    printInColor "function remove" $YELLOW

    # TODO add apt command to remove the package
    echo "Remove dependencies"

    for dep in "${deps[@]}" 
    do
        printf "Remove package %s\n" "$dep"
        remove_with_apt "$dep"  
    done

    # TODO add apt commands to autoremove and clean
    sudo apt autoremove -y \
    && sudo apt autoclean -y; 

    rm -rf $INSTALL_DIR || handle_error "Cannot remove $INSTALL_DIR"

    # TODO if something goes wrong then call function handle_error

}


# TEST

# TODO complete the implementation of this function
function test_minecraft() {
    # Do NOT remove next line!
    printInColor "function test_minecraft" $YELLOW

    # TODO Start minecraft 

    # TODO Check if minecraft is working correctly
        # e.g. by checking the logfile

    # TODO Stop minecraft after testing
        # use the kill signal only if minecraft canNOT be stopped normally

}

function test_spigotserver() {
    # Do NOT remove next line!
    printInColor "function test_spigotserver" $YELLOW

    # TODO Start the spigotserver

    # TODO Check if spigotserver is working correctly
        # e.g. by checking if the API responds
        # if you need curl or aNOTher tool, you have to install it first

    # TODO Stop the spigotserver after testing
        # use the kill signal only if the spigotserver canNOT be stopped normally

}

function setup() {
    printInColor "function setup" $YELLOW

    echo "Install dependencies"

    for dep in "${deps[@]}" 
    do
        printf "Install package %s\n" "$dep"
        install_with_apt "$dep"  
    done

    jre_package=$(echo $JRE_URL | cut -d '/' -f6)   
    echo "JRE_URL : $JRE_URL"
    echo "jre_package : $jre_package"
    package_dir="${INSTALL_DIR}/jre"
    install_package "$jre_package" "$JRE_URL" "$package_dir"    
    sudo apt autoremove -y; 

}

function main() {    
    # Do NOT remove next line!
    printInColor "function main" $YELLOW

    argument_values=("$@")
    nr_of_arguments=${#argument_values[@]}

    if [[ $nr_of_arguments -lt 1 ]]; then
        handle_error "Usage: $0 [action]"
    else
        # Get the first argument from commandline 
        action=$1        
        
        if [[ $nr_of_arguments -gt 1 ]]; then
            # Get the second argument from commandline 
            operation=$2
        fi

    fi


    # Check if the first argument is valid
    # allowed values are "setup" "minecraft" "spigotserver" "remove"
    # bash must exit if value does NOT match one of those values

    [[ -z "${allowedActions[$action]}" ]] && handle_error "Invalid argument ${action}"
   
    case $action in
        "setup")
            echo "setting up the environment..."
            echo "Executing setup..."
            setup "${INSTALL_DIR}"
            ;;

        "remove")
            echo "Executing remove"
            remove
            ;;

        # minecraft with an argument that specifies the one of the following actions
        "minecraft")
            [[ -z $allowedOperations[$operation] ]] && handle_error "$action operation cannot be empty"

            case $operation in            
                # installation of minecraft client      
                "--install")
                    echo "Install Minecraft"
                    install_package "$(basename $MINECRAFT_URL)" "$MINECRAFT_URL" "$minecraft_install_dir"
                    ;;
                
                "--test")
                    echo "Test Minecraft"
                    test_minecraft
                    ;;
                
                # uninstall of minecraft client            
                "--uninstall")
                    echo "Uninstall Minecraft"
                    uninstall_minecraft
                    ;;

                # Default case
                *)
                    handle_error "$0 ${action} ${operation} NOT implemented"
                    ;;

            esac
            ;;

        "spigot")
            [[ -z $operation ]] && handle_error "$action operation cannot be empty"

            case $operation in            
                # installation of spigot server      
                "--install")
                    echo "Install Spigot"
                    package_file="$(basename $BUILDTOOLS_URL)"
                    start_script="spigotstart.sh"
                    start_script_src="${spigot_install_dir}/${start_script}"
                    start_script_target="${spigot_install_dir}/${start_script}"
                    license_file="${spigot_install_dir}/eula.txt"
                    jar_file="${PWD}/*.jar"
                   
					install_package "$package_file" "$BUILDTOOLS_URL" "$spigot_install_dir"
					                    
                    (
						cd $spigot_install_dir || handle_error "Cannot enter ${spigot_install_dir}";
    
                        if [[ ! -f "spigot.jar" ]]; then
						    printf "jar-file: %s\n" "$jar_file";
        	                mv "$jar_file" "spigot.jar" || handle_error "Cannot rename ${jar_file}";
                        fi

					)
					
					if [[ ! -f $start_script_src ]]; then
                    	cp $start_script_src $start_script_target || handle_error "Unable to copy ${start_script_src}"
	                    chmod u+x $start_script_target
					fi

                    echo "Activate eula license"                        
                    echo "eula=true" > $license_file || handle_error "Unable to activate spigot license"

                    create_spigotservice
                    ;;

                # Default case
                *)
                    handle_error "$0 ${action} ${operation} NOT implemented"
                    ;;

                esac
                ;;
            
        # Default case
        *)
            handle_error "${action} NOT implemented"
            ;;
    esac

    # setup that creates the installation directory and installs all required dependencies           

    # remove that removes installation directory and uninstalls all required dependencies (even if they were already installed)

    # minecraft with an argument that specifies the one of the following actions
        # installation of minecraft client
        # wget https://launcher.mojang.com/download/Minecraft.deb
        # test
        # uninstall of minecraft client

    # spigot with an argument that specifies the one of the following actions
        # installation of both spigot server and service
        # test
        # uninstall of both spigot server and service

}

setEnvironmentVariables
main "$@"
