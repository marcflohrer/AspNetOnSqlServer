<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<br />

  <h3 align="center">SQL Server on Linux + ASP.NET 5.0 my-demo-app demo</h3>

  <p align="center">
    <br />
    <a href="https://github.com/marcflohrer/AspNetOnSqlServer"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/marcflohrer/AspNetOnSqlServer/issues/new/choose">Report Bug</a>
    ·
    <a href="https://github.com/marcflohrer/AspNetOnSqlServer/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project is intended to be the starting point when implementing a demo ASP.NET application with a local database on a mac.
I am not sure if it all works on different operating systems as I did not test it.

When starting a new side project this boiler plate code takes unnecessarily a lot of time. Not any more with this template project.

### Built With

This section lists major frameworks and projects that were used:

* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [docker-compose](https://docs.docker.com/compose/)
* [docker](https://docs.docker.com/)
* [Asp.net](https://dotnet.microsoft.com/apps/aspnet)
* [SQL Server on Linux](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-overview?view=sql-server-ver15)
* [aspnetcore/src/Identity/samples/IdentitySample.Mvc/](https://github.com/dotnet/aspnetcore/tree/main/src/Identity/samples/IdentitySample.Mvc) that is [licensed under Apache 2.0](legal/aspnetcore/LICENSE) (Notice: Some files are changed.)
* [EntityFramework Core](https://docs.microsoft.com/en-us/ef/core/)
* [xunit/xunit](https://github.com/xunit/xunit)
* [aspnet/Identity](https://github.com/aspnet/Identity)
* [dotnet/efcore](https://github.com/dotnet/efcore)
* [AutoFixture/AutoFixture](https://github.com/AutoFixture/AutoFixture)
* [microsoft/vstest](https://github.com/microsoft/vstest)
* [xunit/visualstudio.xunit](https://github.com/xunit/visualstudio.xunit)

<!-- GETTING STARTED -->
## Getting Started

First thing should be to change the default database password in the .env file:

  ```.env
  DatabasePassword="YourStr0ngP@ssword!"
  DatabaseConnectionString="Server=db;Database=master;User=sa;Password=YourStr0ngP@ssword!;"
  ```

To start up the app run

  ```sh
  startup-app.sh
  ```

To adjust the database structure to the database description in the project:

  ```sh
  start-dbmigrating.sh
  ```

To reverse engineer the database structure run

  ```sh
  start-dbscaffolding.sh
  ```

### Prerequisites

You need docker and docker-compose on the machine where you want to run the application:

* git
* docker
* docker-compose
* [dotnet 7.0](https://dotnet.microsoft.com/download/dotnet/5.0)
* either [armv7](https://en.wikipedia.org/wiki/ARM_architecture)+ && [ubuntu 20.04](https://ubuntu.com/download/desktop?version=20.04&architecture=amd64)
* or x64 && (mac || linux)
* 1 GB of RAM

### Installation

1. Clone the repo:

   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
   
2. Put a .env file in the **src** folder with the data that match your environment:

   ```sh
   cd /my-demo-app/src
   touch .env
   echo 'DatabasePassword="YourStr0ngP@ssword!"' >> .env
   echo 'DatabaseConnectionString="Server=db;Database=master;User=sa;Password=YourStr0ngP@ssword!;"'  >> .env
   ```

3. Install docker:

   ```sh
   brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
   ```

   or on linux

   ```
   curl -fsSL https://get.docker.com -o get-docker.sh
   sh get-docker.sh
   sudo usermod -aG docker $USER
   sudo reboot
   ssh user@191.XXX.XXX.YY
   sudo chown root:docker /var/run/docker.sock
   sudo apt-get install libffi-dev libssl-dev
   sudo apt install python3-dev
   sudo apt-get install -y python3 python3-pip
   sudo pip3 install docker-compose 
   ```

4. To install dotnet on linux run execute the following commands from the $HOME directory of the user you are logged in with. Check [https://dotnet.microsoft.com/download/dotnet/5.0](https://dotnet.microsoft.com/download/dotnet/5.0) for more recent versions of the dotnet sdk for the arm64 architecture.

   ```sh
   wget https://download.visualstudio.microsoft.com/download/pr/af5f1e5b-d544-47af-b730-038e4258641b/bccb3982f5690134ab66748a5afc36c7/dotnet-sdk-5.0.203-linux-arm64.tar.gz
   mkdir dotnet-64
   tar zxf dotnet-sdk-5.0.203-linux-arm64.tar.gz -C $HOME/dotnet-64
   export DOTNET_ROOT=$HOME/dotnet-64
   export PATH=$HOME/dotnet-64:$PATH
   echo  'export DOTNET_ROOT=$HOME/dotnet-64' >> ~/.bashrc 
   echo  'export PATH=$HOME/dotnet-64:$PATH' >> ~/.bashrc 
   sudo reboot
   ssh user@191.XXX.XXX
   dotnet --info
   ```

5. Before starting the app for the first time on a specific machine go to the **src** folder and run:

   ```sh
   ./start-dbmigrating.sh
   ```

6. Start the app:

   ```sh
   ./startup-app.sh &
   ```
  
7. Wait 1 or 2 minutes and then open [http://localhost](http://localhost) in any browser to see the website.
