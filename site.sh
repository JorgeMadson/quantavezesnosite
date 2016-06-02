#/bin/bash
#A variável 'erro' serve para controlar se o site foi digitado corretamente
erro=1
#o laço do while só é quebrado quando o ping é feito com sucesso retornando '0'
while [ $erro != 0 ]
do
echo "Insira a palavra a ser procurada:"
read  palavra
echo "Insira o site que deseja procurar:"
read site

#Flags do comando ping
# -q faz o ping sem mostrar resultado na tela
# -c numeros de pings
#/dev/null dispositivo nulo, é um arquivo vazio, para descartar o retorno da função
ping -q -c3 $site > /dev/null
if [ $? -eq 0 ]
#$? é o resultado do último comando executado
#E por convenção '0'  é o retorno de sucesso, ou seja, caso o site tenha respondido, caso não, o ping retorna '2'
then
	echo "Site encontrado."
	erro=0
else
	echo "Site não encontrado."
fi
done

#Flags do comando wget
#nv é não verbose, não resultados na tela
#O é o nome do arquivo onde o site será salvo
#r baixa o site recursivamente
#-A.html faz o download apenas dos arquivos html, evitando e imagens e downloads desnecessários
echo "O site está sendo carregado."
wget -nv -r -A.html -O pagina_baixada $site
echo "O número de vezes que '$palavra' foi encontrada em '$site' foi:"

#Flags do comando grep
#c conta a quantidade 
#o é para múltiplas indicidências na mesma linha
#i é para ignorar maiúsculos e minúsculos
grep -oci "$palavra" ./pagina_baixada
#Remove o arquivo 'pagina_baixado' para não encher o disco do usuário
rm pagina_baixada
