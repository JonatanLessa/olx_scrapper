# Scrapper OLX, ETL, DW e OLAP(DESATUALIZADO)
<p align="center">Scrapper OLX usando a categoria Veículos como exemplo com ETL, carga em DW e OLAP</p>

</h4>
<h1 align="center">
<img align="center" width="100" height="30" src="https://www.python.org/static/community_logos/python-logo-master-v3-TM.png" alt="Resume application project app icon">
<img src="https://img.shields.io/static/v1?label=Licenca&message=GPLv3&color=blue&style=plastic&logo=ghost"/>
<img src="https://img.shields.io/static/v1?label=Andamento&message=37%&color=blue&style=plastic&logo=python"/>
</h1>

### 📝 Requisitos
- [Python](https://www.python.org/)
  - webdriver-manager
  - selenium
  - mysql-connector-python
  - python-dotenv
- [MySQL Workbench](https://www.mysql.com/products/workbench/)
- [Pentaho Schema Workbench](https://sourceforge.net/projects/mondrian/files/)
- [Pentaho Server](https://sourceforge.net/projects/pentaho/files/Pentaho-9.2/server/)
- [Drive Java MySQL](https://drive.google.com/file/d/1Q-BJH2DNimc5hduaS8feBNs1ZgEGtGX2/view?usp=drive_web&authuser=1)
- [Saiku Analytics](https://sourceforge.net/projects/argum/files/assets/saiku-plugin-p7.1-3.90.zip/download)
- [Licença Saiku](https://github.com/ambientelivre/saiku-fix/blob/main/saiku-fix-pentaho-8/saiku/license.lic)

### 🤔 Como executar a aplicação?
1. Clone o repositório com o seguinte comando: `git clone https://github.com/JonatanLessa/olx_scrapper.git`
2. Abra o script `olx_vehicle_database.sql` no MySQL Workbench e o execute para criar o Data Warehouse
3. Abra o projeto na pasta `olx_scrapper` com a sua IDE (É recomendável usar o  Visual Studio Code)
4. Crie um arquivo .env com as credenciais do seu DW
    DATABASE_USER= 'preencher'
    DATABASE_PASSWORD= 'preencher'
    DATABASE_NAME= 'preencher'
5. Instale todas as dependências com o comando `pip install` na pasta do projeto
6. Execute o script `scrapper.py` para inicializar a aplicação
7. Baixe o Pentaho Server e descompacte sua pasta na unidade C
8. Baixe o driver mysql-connector-python
9. Baixe o Pentaho Schema Workbench e descompacte sua pasta
10. Na pasta do Schema Workbench mude no arquivo workkbench.bat a linha:
   - Comentar a linha abaixo
      rem "%_PENTAHO_JAVA%" -Xms1024m -Xmx2048m -cp "%CP%" -Dlog4j.configuration=file:///%ROOT%\.schemaWorkbench\log4j.xml mondrian.gui.Workbench
   - Mudar a memória 1024 para 512
      "%_PENTAHO_JAVA%" -Xms512m -Xmx512m -cp "%CP%" -Dlog4j.configuration=file:///%ROOT%\.schemaWorkbench\log4j.xml mondrian.gui.Workbench 
10. Copie o driver mysql-connector-java-5.1.18-bin. para o diretório C:\Pentaho\schema-workbench\drivers
11. Execute o arquivo workbanch.bat no pronpt de comando e abra o arquivo CuboVehicles.xml. Modifique as métricas caso deseje e publique
12. Baixe o Saiku Analytics
13. Copie o arquivo license.lic para a pasta <seupathdeinstalacaopentaho>/pentaho-server/pentaho-solutions/system/saiku
14. Execute o arquivo start-pentaho.bat no prompt de comando e importe a análise publicada




### ⚙️ Tecnologia
- Python
- Selenium
- SQL
- Mondrian
- Saiku Analytics
