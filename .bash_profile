echo "=======================================";
echo "loading bash profile";
export GLASSFISH_PASSWORD=glassfish
export DB_NAME=wordpress
export DB_USER=root
export DB_PASSWORD=pass
export TOMCATADMINPASSWORD=
echo "=======================================";
export CATALINA_HOME=/opt/tomcat
export CATALINA_OPTS="-Xms=512M -Xmx=1024M"
alias serwer='ssh serwer@192.168.0.54 -p 1922'
alias serwersftp='sftp -P 1922 serwer@192.168.0.54'
alias testserwer='ssh serwer@192.168.1.113'
alias release='mvn -B release:clean release:prepare release:perform'

export DB_URL="jdbc:mysql://localhost:3306/$DB_NAME?useUnicode=yes&amp;characterEncoding=UTF-8"
#AUTH_KEY=<?>m<J61O@B*u;#X&{!u%e>Mi-rr{$sN7bdyg|=^MmT$7Z`}^,k16;|+g(S:Vm)-
#SECURE_AUTH_KEY=k!x7+u6CH67eB`510o*+*2OBFC{~&QH#A.3/&kZx=lw|f=<A]GWx&|#@Q*>]6T^.
#LOGGED_IN_KEY=A=S|*m:P+Z9?#S2]Jv8P;]QHY&z[n!KdQi]iNV8#5vv  TZf94-z{zL:|o@E5N-|
#NONCE_KEY=1%;rux<%TvRh,~VMpNvQ&hV!rD|MRqBel~}z|Px?_),H,kKVz3xJ];!hD7>UVhW)
#AUTH_SALT=Zz{H|kaY^V?@{KOrS{gjd,-!e`sN$n&bh]-Mi^S`|5U|_Jk(9QOH11&y9ykGuezD
#SECURE_AUTH_SALT=dxH(y#M-3*O>BS>U|QA+L9ils<}r+yAH?zt~Pa/R+JvSA:*+{~}.l8S`eC;mDZe*
#LOGGED_IN_SALT=sm-OlB!q:7ZP 5f<pVhuw9uIg )jcT|zQjxIH_8R3kTlAx]F)6a})c)xb!P+JaA|
#NONCE_SALT=xL+-cNA+h/,mfRp+KP_k-9,j~n8oP&<]BWzl+D4jD)-8#+-Ei;tOT0&>R%NdA 1X
export ORCHESTRATION=https://github.com/siataman/orchestration.git
export HOSPITAL=https://github.com/siataman/hospital.git
export HOSPITALPLUGIN=https://github.com/siataman/hospitalplugin.git
export HOSPITALPAGE=https://github.com/siataman/hospitalpage.git
export HOSPITALTHEME=https://github.com/siataman/hospitaltheme.git
export EPIDEMIO=https://github.com/siataman/epidemio.git
export PUNCTION=https://github.com/siataman/punction.git
export WARDBOOK=https://siataman@wsz.git.cloudforge.com/wardbook.git
export ORGANISO=https://siataman@wsz.git.cloudforge.com/organiso.git
